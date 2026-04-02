import 'package:drilling_app/features/auth/presentation/feuille_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  @override
  void initState() {
    super.initState();
    Future.microtask(_ensureReferenceData);
  }

  Future<void> _ensureReferenceData() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final db = ref.read(appDatabaseProvider);

      final localProjects = await db.getAllProjects();
      final localEmployees = await db.getAllEmployees();
      final localEquipments = await db.getAllEquipments();
      final localTasks = await db.getAllTasks();
      final localLocations = await db.getAllLocations();

      _setCounts(
        projects: localProjects.length,
        employees: localEmployees.length,
        equipments: localEquipments.length,
        tasks: localTasks.length,
        locations: localLocations.length,
      );

      final hasReferenceData = localProjects.isNotEmpty &&
          localEmployees.isNotEmpty &&
          localEquipments.isNotEmpty &&
          localTasks.isNotEmpty &&
          localLocations.isNotEmpty;

      if (hasReferenceData) {
        _openFeuilleList();
        return;
      }

      await _fetchAndSaveBootstrap();
      _openFeuilleList();
    } catch (e) {
      if (!mounted) {
        return;
      }
      setState(() {
        _error = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _fetchAndSaveBootstrap() async {
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

    _setCounts(
      projects: projects.length,
      employees: employees.length,
      equipments: equipments.length,
      tasks: tasks.length,
      locations: locations.length,
    );
  }

  void _setCounts({
    required int projects,
    required int employees,
    required int equipments,
    required int tasks,
    required int locations,
  }) {
    if (!mounted) {
      return;
    }
    setState(() {
      _projectsCount = projects;
      _employeesCount = employees;
      _equipmentsCount = equipments;
      _tasksCount = tasks;
      _locationsCount = locations;
    });
  }

  void _openFeuilleList() {
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const FeuilleListScreen(),
      ),
    );
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
        title: const Text('Initialisation des donnees'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_loading) ...[
              const LinearProgressIndicator(),
              const SizedBox(height: 16),
              const Text('Chargement automatique des donnees de reference...'),
            ],
            if (_error != null) ...[
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loading ? null : _ensureReferenceData,
                child: const Text('Reessayer le chargement'),
              ),
              const SizedBox(height: 16),
            ],
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
