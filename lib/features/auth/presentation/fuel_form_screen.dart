import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/providers/app_providers.dart';

class FuelFormScreen extends ConsumerStatefulWidget {
  const FuelFormScreen({
    super.key,
    required this.feuilleLocalId,
  });

  final int feuilleLocalId;

  @override
  ConsumerState<FuelFormScreen> createState() => _FuelFormScreenState();
}

class _FuelFormScreenState extends ConsumerState<FuelFormScreen> {
  final _compresseurIdController = TextEditingController();
  final _qytFuelController = TextEditingController();
  final _dateDEquiController = TextEditingController();
  final _dateFEquiController = TextEditingController();
  final _dateDRaviController = TextEditingController();
  final _dateFRaviController = TextEditingController();

  bool _loading = false;
  String? _error;

  Future<void> _save() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final db = ref.read(appDatabaseProvider);

      await db.saveLocalFeuilleFuel(
        feuilleLocalId: widget.feuilleLocalId,
        mobileUuid: const Uuid().v4(),
        compresseurOdooId: _compresseurIdController.text.trim().isEmpty
            ? null
            : int.parse(_compresseurIdController.text.trim()),
        qytFuel: _qytFuelController.text.trim().isEmpty
            ? 0.0
            : double.parse(_qytFuelController.text.trim()),
        dateDEqui: _dateDEquiController.text.trim().isEmpty
            ? null
            : double.parse(_dateDEquiController.text.trim()),
        dateFEqui: _dateFEquiController.text.trim().isEmpty
            ? null
            : double.parse(_dateFEquiController.text.trim()),
        dateDRavi: _dateDRaviController.text.trim().isEmpty
            ? null
            : double.parse(_dateDRaviController.text.trim()),
        dateFRavi: _dateFRaviController.text.trim().isEmpty
            ? null
            : double.parse(_dateFRaviController.text.trim()),
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
    _compresseurIdController.dispose();
    _qytFuelController.dispose();
    _dateDEquiController.dispose();
    _dateFEquiController.dispose();
    _dateDRaviController.dispose();
    _dateFRaviController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter ligne fuel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildField(
                label: 'Equipement Odoo ID',
                controller: _compresseurIdController,
                keyboardType: TextInputType.number,
              ),
              _buildField(
                label: 'Quantite fuel',
                controller: _qytFuelController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              _buildField(
                label: 'Heure debut equipement',
                controller: _dateDEquiController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              _buildField(
                label: 'Heure fin equipement',
                controller: _dateFEquiController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              _buildField(
                label: 'Heure debut ravitaillement',
                controller: _dateDRaviController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              _buildField(
                label: 'Heure fin ravitaillement',
                controller: _dateFRaviController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _save,
                  child: _loading
                      ? const CircularProgressIndicator()
                      : const Text('Ajouter la ligne fuel'),
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
      ),
    );
  }
}
