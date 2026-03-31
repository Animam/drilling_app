import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/providers/app_providers.dart';

class FeuilleFormScreen extends ConsumerStatefulWidget {
  const FeuilleFormScreen({super.key});

  @override
  ConsumerState<FeuilleFormScreen> createState() => _FeuilleFormScreenState();
}

class _FeuilleFormScreenState extends ConsumerState<FeuilleFormScreen> {
  final _projectIdController = TextEditingController();
  final _quartController = TextEditingController();
  final _dateForageController = TextEditingController();
  final _foreuseIdController = TextEditingController();
  final _locationIdController = TextEditingController();
  final _hourMeterController = TextEditingController();
  final _fuelMeterController = TextEditingController();
  final _remarksController = TextEditingController();

  bool _loading = false;
  String? _message;
  String? _error;

  Future<void> _saveFeuille() async {
    setState(() {
      _loading = true;
      _message = null;
      _error = null;
    });

    try {
      final db = ref.read(appDatabaseProvider);

      final projectId = int.parse(_projectIdController.text.trim());
      final quart = _quartController.text.trim();
      final dateForage = _dateForageController.text.trim();

      if (quart.isEmpty) {
        throw Exception('Le champ quart est obligatoire');
      }

      if (dateForage.isEmpty) {
        throw Exception('Le champ date forage est obligatoire');
      }

      await db.saveLocalFeuille(
        mobileUuid: const Uuid().v4(),
        nomProjetOdooId: projectId,
        quart: quart,
        dateForage: dateForage,
        foreuseOdooId: _foreuseIdController.text.trim().isEmpty
            ? null
            : int.parse(_foreuseIdController.text.trim()),
        locationOdooId: _locationIdController.text.trim().isEmpty
            ? null
            : int.parse(_locationIdController.text.trim()),
        hourMeter: _hourMeterController.text.trim().isEmpty
            ? null
            : int.parse(_hourMeterController.text.trim()),
        fuelMeter: _fuelMeterController.text.trim().isEmpty
            ? null
            : _fuelMeterController.text.trim(),
        remarks: _remarksController.text.trim().isEmpty
            ? null
            : _remarksController.text.trim(),
      );

      setState(() {
        _message = 'Feuille enregistree localement';
      });

      _projectIdController.clear();
      _quartController.clear();
      _dateForageController.clear();
      _foreuseIdController.clear();
      _locationIdController.clear();
      _hourMeterController.clear();
      _fuelMeterController.clear();
      _remarksController.clear();
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

  @override
  void dispose() {
    _projectIdController.dispose();
    _quartController.dispose();
    _dateForageController.dispose();
    _foreuseIdController.dispose();
    _locationIdController.dispose();
    _hourMeterController.dispose();
    _fuelMeterController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvelle feuille locale'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(
              label: 'Projet Odoo ID *',
              controller: _projectIdController,
              keyboardType: TextInputType.number,
            ),
            _buildTextField(
              label: 'Quart *',
              controller: _quartController,
            ),
            _buildTextField(
              label: 'Date forage (YYYY-MM-DD) *',
              controller: _dateForageController,
            ),
            _buildTextField(
              label: 'Foreuse Odoo ID',
              controller: _foreuseIdController,
              keyboardType: TextInputType.number,
            ),
            _buildTextField(
              label: 'Location Odoo ID',
              controller: _locationIdController,
              keyboardType: TextInputType.number,
            ),
            _buildTextField(
              label: 'Hour meter',
              controller: _hourMeterController,
              keyboardType: TextInputType.number,
            ),
            _buildTextField(
              label: 'Fuel meter',
              controller: _fuelMeterController,
            ),
            _buildTextField(
              label: 'Remarques',
              controller: _remarksController,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _saveFeuille,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text('Enregistrer localement'),
              ),
            ),
            const SizedBox(height: 16),
            if (_message != null)
              Text(
                _message!,
                style: const TextStyle(color: Colors.green),
              ),
            if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
