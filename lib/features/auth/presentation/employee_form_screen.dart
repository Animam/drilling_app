import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/providers/app_providers.dart';

class EmployeFormScreen extends ConsumerStatefulWidget {
  const EmployeFormScreen({
    super.key,
    required this.feuilleLocalId,
  });

  final int feuilleLocalId;

  @override
  ConsumerState<EmployeFormScreen> createState() => _EmployeFormScreenState();
}

class _EmployeFormScreenState extends ConsumerState<EmployeFormScreen> {
  final _employeeIdController = TextEditingController();
  final _fonctionController = TextEditingController();
  final _observationController = TextEditingController();
  final _dateEmpController = TextEditingController();
  final _dateDebutController = TextEditingController();
  final _dateFinController = TextEditingController();
  final _differenceController = TextEditingController();

  bool _absent = false;
  bool _loading = false;
  String? _error;

  Future<void> _save() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final db = ref.read(appDatabaseProvider);

      await db.saveLocalFeuilleEmploye(
        feuilleLocalId: widget.feuilleLocalId,
        mobileUuid: const Uuid().v4(),
        employeeOdooId: int.parse(_employeeIdController.text.trim()),
        fonction: _fonctionController.text.trim().isEmpty
            ? null
            : _fonctionController.text.trim(),
        observation: _observationController.text.trim().isEmpty
            ? null
            : _observationController.text.trim(),
        dateEmp: _dateEmpController.text.trim().isEmpty
            ? null
            : _dateEmpController.text.trim(),
        dateDebut: _dateDebutController.text.trim().isEmpty
            ? null
            : _dateDebutController.text.trim(),
        dateFin: _dateFinController.text.trim().isEmpty
            ? null
            : _dateFinController.text.trim(),
        difference: _differenceController.text.trim().isEmpty
            ? null
            : double.parse(_differenceController.text.trim()),
        absent: _absent,
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
    _employeeIdController.dispose();
    _fonctionController.dispose();
    _observationController.dispose();
    _dateEmpController.dispose();
    _dateDebutController.dispose();
    _dateFinController.dispose();
    _differenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter employe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildField(
                label: 'Employe Odoo ID *',
                controller: _employeeIdController,
                keyboardType: TextInputType.number,
              ),
              _buildField(
                label: 'Fonction',
                controller: _fonctionController,
              ),
              _buildField(
                label: 'Observation',
                controller: _observationController,
              ),
              _buildField(
                label: 'Date',
                controller: _dateEmpController,
              ),
              _buildField(
                label: 'Date debut',
                controller: _dateDebutController,
              ),
              _buildField(
                label: 'Date fin',
                controller: _dateFinController,
              ),
              _buildField(
                label: 'Difference',
                controller: _differenceController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              SwitchListTile(
                title: const Text('Absent'),
                value: _absent,
                onChanged: (value) {
                  setState(() {
                    _absent = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _save,
                  child: _loading
                      ? const CircularProgressIndicator()
                      : const Text('Ajouter employe'),
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
