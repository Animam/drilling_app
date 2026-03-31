import 'package:drilling_app/data/local/db/app_database.dart';
import 'package:drilling_app/features/auth/presentation/employee_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/app_providers.dart';

class FeuilleEmployesScreen extends ConsumerStatefulWidget {
  const FeuilleEmployesScreen({
    super.key,
    required this.feuilleLocalId,
  });

  final int feuilleLocalId;

  @override
  ConsumerState<FeuilleEmployesScreen> createState() => _FeuilleEmployesScreenState();
}

class _FeuilleEmployesScreenState extends ConsumerState<FeuilleEmployesScreen> {
  List<FeuilleEmploye> _items = [];

  Future<void> _load() async {
    final db = ref.read(appDatabaseProvider);
    final data = await db.getEmployesByFeuille(widget.feuilleLocalId);

    setState(() {
      _items = data;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(_load);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => EmployeFormScreen(
                feuilleLocalId: widget.feuilleLocalId,
              ),
            ),
          );
          _load();
        },
        child: const Icon(Icons.add),
      ),
      body: _items.isEmpty
          ? const Center(child: Text('Aucun employe'))
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return ListTile(
                  title: Text('Employe ID: ${item.employeeOdooId}'),
                  subtitle: Text(
                    'Fonction: ${item.fonction ?? '-'} | Absent: ${item.absent ? "Oui" : "Non"}',
                  ),
                );
              },
            ),
    );
  }
}
