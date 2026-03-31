/* import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/api_providers.dart';

class BootstrapScreen extends ConsumerStatefulWidget {
  const BootstrapScreen({super.key});

  @override
  ConsumerState<BootstrapScreen> createState() => _BootstrapScreenState();
}

class _BootstrapScreenState extends ConsumerState<BootstrapScreen> {
  bool _loading = false;
  String? _error;
  List<Map<String, dynamic>> _projects = [];

  Future<void> _testBootstrap() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final api = ref.read(bootstrapApiProvider);
      final result = await api.fetchBootstrap();

      final projects = (result['projects'] as List<dynamic>? ?? [])
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();

      setState(() {
        _projects = projects;
      });
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tester Bootstrap'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _testBootstrap,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text('Tester bootstrap'),
              ),
            ),
            const SizedBox(height: 16),
            if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),
            Expanded(
              child: _projects.isEmpty
                  ? const Center(
                      child: Text('Aucun projet charge'),
                    )
                  : ListView.builder(
                      itemCount: _projects.length,
                      itemBuilder: (context, index) {
                        final project = _projects[index];
                        return Card(
                          child: ListTile(
                            title: Text(project['name']?.toString() ?? '-'),
                            subtitle: Text(
                              'odoo_id: ${project['odoo_id']}',
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
 */


import 'package:drilling_app/features/auth/presentation/feuille_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/presentation/feuille_form_screen.dart';
import '../../../shared/providers/api_providers.dart';
import '../../../shared/providers/app_providers.dart';

class BootstrapScreen extends ConsumerStatefulWidget {
  const BootstrapScreen({super.key});

  @override
  ConsumerState<BootstrapScreen> createState() => _BootstrapScreenState();
}

class _BootstrapScreenState extends ConsumerState<BootstrapScreen> {
  bool _loading = false;
  String? _error;

  int _projectsCount = 0;
  int _employeesCount = 0;
  int _equipmentsCount = 0;
  int _tasksCount = 0;
  int _locationsCount = 0;

  Future<void> _testBootstrap() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final api = ref.read(bootstrapApiProvider);
      final db = ref.read(appDatabaseProvider);

      final result = await api.fetchBootstrap();


      final projects = (result['projects'] as List<dynamic>? ?? [])
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();

      final employees = (result['employees'] as List<dynamic>? ?? [])
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();

      final equipments = (result['equipments'] as List<dynamic>? ?? [])
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();

      final tasks = (result['tasks'] as List<dynamic>? ?? [])
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();

      final locations = (result['locations'] as List<dynamic>? ?? [])
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();

      await db.saveProjects(projects);
      await db.saveEmployees(employees);
      await db.saveEquipments(equipments);
      await db.saveTasks(tasks);
      await db.saveLocations(locations);

      final localProjects = await db.getAllProjects();
      final localEmployees = await db.getAllEmployees();
      final localEquipments = await db.getAllEquipments();
      final localTasks = await db.getAllTasks();
      final localLocations = await db.getAllLocations();

      setState(() {
        _projectsCount = localProjects.length;
        _employeesCount = localEmployees.length;
        _equipmentsCount = localEquipments.length;
        _tasksCount = localTasks.length;
        _locationsCount = localLocations.length;
      });
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

  Widget _buildCountCard(String title, int count) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Text(
          count.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bootstrap local'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _testBootstrap,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text('Charger et enregistrer le bootstrap'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const FeuilleFormScreen(),
                    ),
                  );
                },
                child: const Text('Ouvrir le formulaire de feuille'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const FeuilleListScreen(),
                    ),
                  );
                },
                child: const Text('Ouvrir la list de feuille'),
              ),
            ),
            const SizedBox(height: 16),
            if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 8),
            _buildCountCard('Projects', _projectsCount),
            _buildCountCard('Employees', _employeesCount),
            _buildCountCard('Equipments', _equipmentsCount),
            _buildCountCard('Tasks', _tasksCount),
            _buildCountCard('Locations', _locationsCount),
          ],
        ),
      ),
    );
  }
}
