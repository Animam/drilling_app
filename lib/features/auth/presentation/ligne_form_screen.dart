import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/providers/app_providers.dart';

class LigneFormScreen extends ConsumerStatefulWidget {
  const LigneFormScreen({
    super.key,
    required this.feuilleLocalId,
  });

  final int feuilleLocalId;

  @override
  ConsumerState<LigneFormScreen> createState() => _LigneFormScreenState();
}

class _LigneFormScreenState extends ConsumerState<LigneFormScreen> {
  final _itemController = TextEditingController();
  final _dateDController = TextEditingController();
  final _dateFController = TextEditingController();
  final _rrController = TextEditingController();
  final _noteController = TextEditingController();

  bool _loading = false;
  String? _error;

  Future<void> _save() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final db = ref.read(appDatabaseProvider);

      await db.saveLocalFeuilleLigne(
        feuilleLocalId: widget.feuilleLocalId,
        mobileUuid: const Uuid().v4(),
        item: _itemController.text.trim(),
        dateD: _dateDController.text.trim().isEmpty
            ? null
            : double.parse(_dateDController.text.trim()),
        dateF: _dateFController.text.trim().isEmpty
            ? null
            : double.parse(_dateFController.text.trim()),
        rr: _rrController.text.trim().isEmpty
            ? null
            : double.parse(_rrController.text.trim()),
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
      );

      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _itemController.dispose();
    _dateDController.dispose();
    _dateFController.dispose();
    _rrController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une ligne'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildField(label: 'Item *', controller: _itemController),
            _buildField(
              label: 'Heure debut',
              controller: _dateDController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            _buildField(
              label: 'Heure fin',
              controller: _dateFController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            _buildField(
              label: 'Duree rr',
              controller: _rrController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            _buildField(label: 'Note', controller: _noteController),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _save,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text('Ajouter la ligne'),
              ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
