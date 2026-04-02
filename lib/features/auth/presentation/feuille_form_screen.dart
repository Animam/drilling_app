import 'package:drilling_app/data/local/db/app_database.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/providers/app_providers.dart';

String _formatDurationHour(double? value) {
  if (value == null) {
    return '';
  }
  final totalMinutes = (value * 60).round();
  final hours = totalMinutes ~/ 60;
  final minutes = totalMinutes % 60;
  final hh = hours.toString().padLeft(2, '0');
  final mm = minutes.toString().padLeft(2, '0');
  return '$hh:$mm';
}

String _formatDecimalHour(double? value) {
  if (value == null) {
    return '';
  }
  final totalMinutes = (value * 60).round();
  final hours = (totalMinutes ~/ 60) % 24;
  final minutes = totalMinutes % 60;
  final hh = hours.toString().padLeft(2, '0');
  final mm = minutes.toString().padLeft(2, '0');
  return '$hh:$mm';
}

double? _parseFlexibleHour(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) {
    return null;
  }
  if (trimmed.contains(':')) {
    final parts = trimmed.split(':');
    if (parts.length != 2) {
      throw const FormatException('Heure invalide');
    }
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    if (hours < 0 || hours > 23 || minutes < 0 || minutes > 59) {
      throw const FormatException('Heure invalide');
    }
    return hours + (minutes / 60.0);
  }
  return double.parse(trimmed.replaceAll(',', '.'));
}


class _TimeLogDraft {
  _TimeLogDraft();
  factory _TimeLogDraft.fromRow(FeuilleLigne row) {
    final draft = _TimeLogDraft();
    draft.debut.text = _formatDecimalHour(row.dateD);
    draft.fin.text = _formatDecimalHour(row.dateF);
    draft.item.text = row.item;
    draft.holeNo.text = row.holeNo ?? '';
    draft.fromDim.text = row.fromDim?.toString() ?? '';
    draft.toDim.text = row.toDim?.toString() ?? '';
    draft.totalDim.text = row.totalDim?.toString() ?? '';
    draft.taskId.text = row.tacheOdooId?.toString() ?? '';
    draft.selectedTaskOdooId = row.tacheOdooId;
    draft.comment.text = row.note ?? '';
    draft.distance.text = row.distance?.toString() ?? '';
    draft.duration.text = row.rr?.toString() ?? '';
    return draft;
  }

  final debut = TextEditingController();
  final fin = TextEditingController();
  final item = TextEditingController();
  final holeNo = TextEditingController();
  final fromDim = TextEditingController();
  final toDim = TextEditingController();
  final totalDim = TextEditingController();
  final taskId = TextEditingController();
  int? selectedTaskOdooId;
  final comment = TextEditingController();
  final distance = TextEditingController();
  final duration = TextEditingController();

  bool get hasData => [
    debut,
    fin,
    item,
    holeNo,
    fromDim,
    toDim,
    totalDim,
    taskId,
    comment,
    distance,
    duration,
  ].any((c) => c.text.trim().isNotEmpty);
  void clear() {
    debut.clear();
    fin.clear();
    item.clear();
    holeNo.clear();
    fromDim.clear();
    toDim.clear();
    totalDim.clear();
    taskId.clear();
    selectedTaskOdooId = null;
    comment.clear();
    distance.clear();
    duration.clear();
  }

  void dispose() {
    debut.dispose();
    fin.dispose();
    item.dispose();
    holeNo.dispose();
    fromDim.dispose();
    toDim.dispose();
    totalDim.dispose();
    taskId.dispose();
    comment.dispose();
    distance.dispose();
    duration.dispose();
  }
}

class _EmployeeDraft {
  _EmployeeDraft();
  factory _EmployeeDraft.fromRow(FeuilleEmploye row) {
    final draft = _EmployeeDraft();
    draft.employeeId.text = row.employeeOdooId.toString();
    draft.fonction.text = row.fonction ?? '';
    draft.hDebut.text = row.dateDebut ?? '';
    draft.hFin.text = row.dateFin ?? '';
    draft.total.text = row.difference?.toString() ?? '';
    draft.observation.text = row.observation ?? '';
    draft.absent = row.absent;
    return draft;
  }

  final employeeId = TextEditingController();
  final fonction = TextEditingController();
  final hDebut = TextEditingController();
  final hFin = TextEditingController();
  final total = TextEditingController();
  final observation = TextEditingController();
  bool absent = false;

  bool get hasData =>
      [
        employeeId,
        fonction,
        hDebut,
        hFin,
        total,
        observation,
      ].any((c) => c.text.trim().isNotEmpty) ||
      absent;
  void clear() {
    employeeId.clear();
    fonction.clear();
    hDebut.clear();
    hFin.clear();
    total.clear();
    observation.clear();
    absent = false;
  }

  void dispose() {
    employeeId.dispose();
    fonction.dispose();
    hDebut.dispose();
    hFin.dispose();
    total.dispose();
    observation.dispose();
  }
}

class _FuelDraft {
  _FuelDraft();
  factory _FuelDraft.fromRow(FeuilleFuel row) {
    final draft = _FuelDraft();
    draft.equipmentId.text = row.compresseurOdooId?.toString() ?? '';
    draft.quantity.text = row.qytFuel.toString();
    draft.hrDebut.text = _formatDecimalHour(row.dateDEqui);
    draft.hrFin.text = _formatDecimalHour(row.dateFEqui);
    draft.hrDebutRavi.text = _formatDecimalHour(row.dateDRavi);
    draft.hrFinRavi.text = _formatDecimalHour(row.dateFRavi);
    return draft;
  }

  final equipmentId = TextEditingController();
  final quantity = TextEditingController();
  final hrDebut = TextEditingController();
  final hrFin = TextEditingController();
  final hrDebutRavi = TextEditingController();
  final hrFinRavi = TextEditingController();

  bool get hasData => [
    equipmentId,
    quantity,
    hrDebut,
    hrFin,
    hrDebutRavi,
    hrFinRavi,
  ].any((c) => c.text.trim().isNotEmpty);
  void clear() {
    equipmentId.clear();
    quantity.clear();
    hrDebut.clear();
    hrFin.clear();
    hrDebutRavi.clear();
    hrFinRavi.clear();
  }

  void dispose() {
    equipmentId.dispose();
    quantity.dispose();
    hrDebut.dispose();
    hrFin.dispose();
    hrDebutRavi.dispose();
    hrFinRavi.dispose();
  }
}

class _MaterialDraft {
  _MaterialDraft();
  factory _MaterialDraft.fromRow(FeuilleMateriel row) {
    final draft = _MaterialDraft();
    draft.description.text = row.description ?? '';
    draft.serialNumber.text = row.serialNumber ?? '';
    draft.quantity.text = row.quantity?.toString() ?? '';
    draft.observation.text = row.observation ?? '';
    draft.status.text = row.status ?? '';
    return draft;
  }

  final description = TextEditingController();
  final serialNumber = TextEditingController();
  final quantity = TextEditingController();
  final observation = TextEditingController();
  final status = TextEditingController();

  bool get hasData => [
    description,
    serialNumber,
    quantity,
    observation,
    status,
  ].any((c) => c.text.trim().isNotEmpty);
  void clear() {
    description.clear();
    serialNumber.clear();
    quantity.clear();
    observation.clear();
    status.clear();
  }

  void dispose() {
    description.dispose();
    serialNumber.dispose();
    quantity.dispose();
    observation.dispose();
    status.dispose();
  }
}

class FeuilleFormScreen extends ConsumerStatefulWidget {
  const FeuilleFormScreen({super.key, this.feuilleLocalId});
  final int? feuilleLocalId;
  bool get isEditMode => feuilleLocalId != null;

  @override
  ConsumerState<FeuilleFormScreen> createState() => _FeuilleFormScreenState();
}

class _FeuilleFormScreenState extends ConsumerState<FeuilleFormScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  final _projectIdController = TextEditingController();
  final _clientController = TextEditingController();
  final _quartController = TextEditingController();
  final _foreuseIdController = TextEditingController();
  final _superviseurController = TextEditingController();
  final _operateurController = TextEditingController();
  final _fuelMeterController = TextEditingController();
  final _dateForageController = TextEditingController();
  final _locationIdController = TextEditingController();
  final _hourMeterController = TextEditingController();
  final _remarksController = TextEditingController();

  List<Project> _projects = [];
  List<Equipment> _equipments = [];
  List<Location> _locations = [];
  List<Task> _tasks = [];
  int? _selectedProjectOdooId;
  int? _selectedForeuseOdooId;
  int? _selectedLocationOdooId;

  final List<_TimeLogDraft> _timeLogs = [];
  final List<_EmployeeDraft> _employees = [];
  final List<_FuelDraft> _fuels = [];
  final List<_MaterialDraft> _materials = [];

  bool _loading = false;
  bool _initialLoading = false;
  String? _error;
  String? _existingMobileUuid;
  int? _existingOdooId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _resetDraftLists();
    if (!widget.isEditMode) {
      _dateForageController.text = DateTime.now()
          .toIso8601String()
          .split('T')
          .first;
    }
    Future.microtask(_loadReferenceData);
    if (widget.isEditMode) {
      _loadExistingFeuille();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _projectIdController.dispose();
    _clientController.dispose();
    _quartController.dispose();
    _foreuseIdController.dispose();
    _superviseurController.dispose();
    _operateurController.dispose();
    _fuelMeterController.dispose();
    _dateForageController.dispose();
    _locationIdController.dispose();
    _hourMeterController.dispose();
    _remarksController.dispose();
    for (final row in _timeLogs) {
      row.dispose();
    }
    for (final row in _employees) {
      row.dispose();
    }
    for (final row in _fuels) {
      row.dispose();
    }
    for (final row in _materials) {
      row.dispose();
    }
    super.dispose();
  }

  void _resetDraftLists() {
    for (final row in _timeLogs) {
      row.dispose();
    }
    for (final row in _employees) {
      row.dispose();
    }
    for (final row in _fuels) {
      row.dispose();
    }
    for (final row in _materials) {
      row.dispose();
    }
    _timeLogs.clear();
    _employees.clear();
    _fuels.clear();
    _materials.clear();
  }

  Future<void> _loadReferenceData() async {
    try {
      final db = ref.read(appDatabaseProvider);
      final projects = await db.getAllProjects();
      final equipments = await db.getAllEquipments();
      final locations = await db.getAllLocations();
      final tasks = await db.getAllTasks();
      if (!mounted) {
        return;
      }
      setState(() {
        _projects = projects;
        _equipments = equipments;
        _locations = locations;
        _tasks = tasks;
      });
      _syncClientFromSelectedProject();
      _autoFillQuartFromSelectedProject();
      _normalizeForeuseSelection();
      _syncForeuseControllerFromSelection();
      _syncLocationControllerFromSelection();
      for (final row in _timeLogs) {
        if (row.selectedTaskOdooId != null) {
          _syncItemFromTask(row);
        } else if (row.item.text.trim().isNotEmpty) {
          _syncTaskFromItem(row);
        }
      }
    } catch (_) {}
  }

  void _syncClientFromSelectedProject() {
    if (_selectedProjectOdooId == null) {
      _clientController.clear();
      return;
    }
    final match = _projects
        .where((project) => project.odooId == _selectedProjectOdooId)
        .toList();
    if (match.isEmpty) {
      return;
    }
    _clientController.text = match.first.partnerName ?? '';
    _projectIdController.text = match.first.odooId.toString();
  }

  void _syncForeuseControllerFromSelection() {
    _foreuseIdController.text = _selectedForeuseOdooId?.toString() ?? '';
  }

  double _currentHourAsDouble() {
    final now = DateTime.now();
    return now.hour + (now.minute / 60.0);
  }

  void _autoFillQuartFromSelectedProject() {
    if (_selectedProjectOdooId == null) {
      return;
    }
    final match = _projects
        .where((project) => project.odooId == _selectedProjectOdooId)
        .toList();
    if (match.isEmpty) {
      return;
    }
    final project = match.first;
    final dateDJ = project.dateDJ;
    final dateDN = project.dateDN;
    if (dateDJ == null || dateDN == null) {
      return;
    }
    final currentHour = _currentHourAsDouble();
    if (dateDJ < dateDN) {
      _quartController.text = currentHour >= dateDJ && currentHour < dateDN
          ? 'Day/Jour'
          : 'Night/Nuit';
      return;
    }
    _quartController.text = currentHour >= dateDJ || currentHour < dateDN
        ? 'Day/Jour'
        : 'Night/Nuit';
  }

  void _syncLocationControllerFromSelection() {
    _locationIdController.text = _selectedLocationOdooId?.toString() ?? '';
  }

  Task? _findTaskByItem(String item) {
    final normalized = item.trim();
    if (normalized.isEmpty) {
      return null;
    }
    for (final task in _tasks) {
      if ((task.numItem ?? '').trim() == normalized) {
        return task;
      }
    }
    return null;
  }

  Task? _findTaskByOdooId(int? taskOdooId) {
    if (taskOdooId == null) {
      return null;
    }
    for (final task in _tasks) {
      if (task.odooId == taskOdooId) {
        return task;
      }
    }
    return null;
  }

  void _syncTaskFromItem(_TimeLogDraft row) {
    final task = _findTaskByItem(row.item.text);
    row.selectedTaskOdooId = task?.odooId;
    row.taskId.text = task?.odooId.toString() ?? '';
  }

  void _syncItemFromTask(_TimeLogDraft row) {
    final task = _findTaskByOdooId(row.selectedTaskOdooId);
    row.item.text = task?.numItem ?? '';
    row.taskId.text = task?.odooId.toString() ?? '';
  }

  List<Equipment> get _availableForeuses {
    final selectedProjectId = _selectedProjectOdooId;
    return _equipments.where((equipment) {
      final category = (equipment.categoryName ?? '').toLowerCase();
      final isForeuse = category.contains('foreuse');
      if (!isForeuse) {
        return false;
      }
      if (selectedProjectId == null) {
        return true;
      }
      return equipment.projectOdooId == null ||
          equipment.projectOdooId == selectedProjectId;
    }).toList();
  }

  void _normalizeForeuseSelection() {
    final availableIds = _availableForeuses
        .map((equipment) => equipment.odooId)
        .toSet();
    if (_selectedForeuseOdooId != null &&
        !availableIds.contains(_selectedForeuseOdooId)) {
      _selectedForeuseOdooId = null;
      _syncForeuseControllerFromSelection();
    }
  }

  Future<void> _loadExistingFeuille() async {
    setState(() {
      _initialLoading = true;
      _error = null;
    });
    try {
      final db = ref.read(appDatabaseProvider);
      final feuille =
          await (db.select(db.feuilles)
                ..where((tbl) => tbl.localId.equals(widget.feuilleLocalId!)))
              .getSingle();
      final lignes = await db.getLignesByFeuille(widget.feuilleLocalId!);
      final fuels = await db.getFuelsByFeuille(widget.feuilleLocalId!);
      final employes = await db.getEmployesByFeuille(widget.feuilleLocalId!);
      final materiels = await db.getMaterielsByFeuille(widget.feuilleLocalId!);

      _projectIdController.text = feuille.nomProjetOdooId.toString();
      _selectedProjectOdooId = feuille.nomProjetOdooId;
      _quartController.text = feuille.quart;
      _dateForageController.text = feuille.dateForage;
      _foreuseIdController.text = feuille.foreuseOdooId?.toString() ?? '';
      _locationIdController.text = feuille.locationOdooId?.toString() ?? '';
      _selectedForeuseOdooId = feuille.foreuseOdooId;
      _selectedLocationOdooId = feuille.locationOdooId;
      _hourMeterController.text = feuille.hourMeter?.toString() ?? '';
      _fuelMeterController.text = feuille.fuelMeter ?? '';
      _remarksController.text = feuille.remarks ?? '';
      _existingMobileUuid = feuille.mobileUuid;
      _existingOdooId = feuille.odooId;
      _syncClientFromSelectedProject();
      _autoFillQuartFromSelectedProject();
      _normalizeForeuseSelection();
      _syncForeuseControllerFromSelection();
      _syncLocationControllerFromSelection();

      for (final row in _timeLogs) {
        row.dispose();
      }
      for (final row in _employees) {
        row.dispose();
      }
      for (final row in _fuels) {
        row.dispose();
      }
      for (final row in _materials) {
        row.dispose();
      }

      _timeLogs
        ..clear()
        ..addAll(lignes.map(_TimeLogDraft.fromRow));
      _employees
        ..clear()
        ..addAll(employes.map(_EmployeeDraft.fromRow));
      _fuels
        ..clear()
        ..addAll(fuels.map(_FuelDraft.fromRow));
      _materials
        ..clear()
        ..addAll(materiels.map(_MaterialDraft.fromRow));
    } catch (e) {
      _error = e.toString();
    } finally {
      if (mounted) {
        setState(() {
          _initialLoading = false;
        });
      }
    }
  }

  void _recomputeTotalDim(_TimeLogDraft row) {
    final fromValue = _parseInt(row.fromDim.text);
    final toValue = _parseInt(row.toDim.text);
    if (fromValue == null || toValue == null) {
      row.totalDim.text = '';
      return;
    }
    row.totalDim.text = (toValue - fromValue).toString();
  }

  void _recomputeDuration(_TimeLogDraft row) {
    final start = _parseHour(row.debut.text);
    final end = _parseHour(row.fin.text);
    if (start == null || end == null) {
      row.duration.text = '';
      return;
    }
    final duration = end >= start ? end - start : (end + 24.0) - start;
    row.duration.text = _formatDurationHour(duration);
  }

  int? _parseInt(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    return int.parse(trimmed);
  }

  double? _parseDouble(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    if (trimmed.contains(':')) {
      return _parseFlexibleHour(trimmed);
    }
    return double.parse(trimmed.replaceAll(',', '.'));
  }

  double? _parseHour(String value) {
    return _parseFlexibleHour(value);
  }

  String _defaultStartTimeForNewTimeRow() {
    if (_timeLogs.isNotEmpty) {
      final previousEnd = _timeLogs.last.fin.text.trim();
      if (previousEnd.isNotEmpty) {
        return previousEnd;
      }
    }
    if (_selectedProjectOdooId == null) {
      return '';
    }
    final project = _projects.where((item) => item.odooId == _selectedProjectOdooId).firstOrNull;
    if (project == null) {
      return '';
    }
    final quart = _quartController.text.trim();
    if (quart == 'Day/Jour') {
      return _formatDecimalHour(project.dateDJ);
    }
    if (quart == 'Night/Nuit') {
      return _formatDecimalHour(project.dateDN);
    }
    return '';
  }

  double get _totalFuel => _fuels.fold<double>(
    0,
    (sum, row) => sum + (_parseDouble(row.quantity.text) ?? 0),
  );
  double get _totalHours => _timeLogs.fold<double>(
    0,
    (sum, row) => sum + (_parseDouble(row.duration.text) ?? 0),
  );
  int get _totalMeters => _timeLogs.fold<int>(
    0,
    (sum, row) => sum + (_parseInt(row.totalDim.text) ?? 0),
  );

  void _clearOrRemoveTimeRow(int index) {
    setState(() {
      if (_timeLogs.length == 1) {
        final row = _timeLogs.removeAt(index);
        row.dispose();
        return;
      }
      final row = _timeLogs.removeAt(index);
      row.dispose();
    });
  }

  void _clearOrRemoveEmployeeRow(int index) {
    setState(() {
      if (_employees.length == 1) {
        final row = _employees.removeAt(index);
        row.dispose();
        return;
      }
      final row = _employees.removeAt(index);
      row.dispose();
    });
  }

  void _clearOrRemoveFuelRow(int index) {
    setState(() {
      if (_fuels.length == 1) {
        final row = _fuels.removeAt(index);
        row.dispose();
        return;
      }
      final row = _fuels.removeAt(index);
      row.dispose();
    });
  }

  void _clearOrRemoveMaterialRow(int index) {
    setState(() {
      if (_materials.length == 1) {
        final row = _materials.removeAt(index);
        row.dispose();
        return;
      }
      final row = _materials.removeAt(index);
      row.dispose();
    });
  }

  void _addTimeRow() {
    setState(() {
      final draft = _TimeLogDraft();
      draft.debut.text = _defaultStartTimeForNewTimeRow();
      _timeLogs.add(draft);
    });
  }
  void _addEmployeeRow() => setState(() => _employees.add(_EmployeeDraft()));
  void _addFuelRow() => setState(() => _fuels.add(_FuelDraft()));
  void _addMaterialRow() => setState(() => _materials.add(_MaterialDraft()));
  Future<void> _saveAll() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final db = ref.read(appDatabaseProvider);
      final projectId =
          _selectedProjectOdooId ?? _parseInt(_projectIdController.text);
      final quart = _quartController.text.trim();
      final dateForage = _dateForageController.text.trim();
      if (projectId == null) {
        throw Exception('Projet Odoo ID est obligatoire');
      }
      if (quart.isEmpty) {
        throw Exception('Quart est obligatoire');
      }
      if (dateForage.isEmpty) throw Exception('Date forage est obligatoire');

      final filledTimeRows = _timeLogs.where((row) => row.hasData).toList();
      final filledEmployeeRows = _employees
          .where((row) => row.hasData)
          .toList();
      final filledFuelRows = _fuels.where((row) => row.hasData).toList();
      final filledMaterialRows = _materials
          .where((row) => row.hasData)
          .toList();

      for (final row in filledTimeRows) {
        if (row.item.text.trim().isEmpty) {
          throw Exception(
            'Chaque ligne de temps renseignee doit avoir un item',
          );
        }
      }
      for (final row in filledEmployeeRows) {
        if (_parseInt(row.employeeId.text) == null) {
          throw Exception(
            'Chaque ligne employe renseignee doit avoir un Employe Odoo ID',
          );
        }
      }

      final totalFuel = _totalFuel.toStringAsFixed(2);
      final now = DateTime.now().toIso8601String();

      await db.transaction(() async {
        late final int feuilleLocalId;
        if (widget.isEditMode) {
          feuilleLocalId = widget.feuilleLocalId!;
          await (db.update(
            db.feuilles,
          )..where((tbl) => tbl.localId.equals(feuilleLocalId))).write(
            FeuillesCompanion(
              mobileUuid: Value(_existingMobileUuid ?? const Uuid().v4()),
              odooId: Value(_existingOdooId),
              nomProjetOdooId: Value(projectId),
              quart: Value(quart),
              dateForage: Value(dateForage),
              foreuseOdooId: Value(_parseInt(_foreuseIdController.text)),
              locationOdooId: Value(_parseInt(_locationIdController.text)),
              hourMeter: Value(_parseInt(_hourMeterController.text)),
              fuelMeter: Value(
                _fuelMeterController.text.trim().isEmpty
                    ? totalFuel
                    : _fuelMeterController.text.trim(),
              ),
              remarks: Value(_buildRemarksPayload()),
              updatedAt: Value(now),
            ),
          );
          await (db.delete(
            db.feuilleLignes,
          )..where((tbl) => tbl.feuilleLocalId.equals(feuilleLocalId))).go();
          await (db.delete(
            db.feuilleFuels,
          )..where((tbl) => tbl.feuilleLocalId.equals(feuilleLocalId))).go();
          await (db.delete(
            db.feuilleEmployes,
          )..where((tbl) => tbl.feuilleLocalId.equals(feuilleLocalId))).go();
          await (db.delete(
            db.feuilleMateriels,
          )..where((tbl) => tbl.feuilleLocalId.equals(feuilleLocalId))).go();
        } else {
          feuilleLocalId = await db.saveLocalFeuille(
            mobileUuid: const Uuid().v4(),
            nomProjetOdooId: projectId,
            quart: quart,
            dateForage: dateForage,
            foreuseOdooId: _parseInt(_foreuseIdController.text),
            locationOdooId: _parseInt(_locationIdController.text),
            hourMeter: _parseInt(_hourMeterController.text),
            fuelMeter: _fuelMeterController.text.trim().isEmpty
                ? totalFuel
                : _fuelMeterController.text.trim(),
            remarks: _buildRemarksPayload(),
          );
        }

        var sequence = 10;
        for (final row in filledTimeRows) {
          await db.saveLocalFeuilleLigne(
            feuilleLocalId: feuilleLocalId,
            mobileUuid: const Uuid().v4(),
            item: row.item.text.trim(),
            tacheOdooId: _parseInt(row.taskId.text),
            holeNo: row.holeNo.text.trim().isEmpty
                ? null
                : row.holeNo.text.trim(),
            note: row.comment.text.trim().isEmpty
                ? null
                : row.comment.text.trim(),
            dateD: _parseHour(row.debut.text),
            dateF: _parseHour(row.fin.text),
            rr: _parseDouble(row.duration.text),
            distance: _parseInt(row.distance.text),
            fromDim: _parseInt(row.fromDim.text),
            toDim: _parseInt(row.toDim.text),
            totalDim: _parseInt(row.totalDim.text),
            sequence: sequence,
          );
          sequence += 10;
        }

        for (final row in filledFuelRows) {
          await db.saveLocalFeuilleFuel(
            feuilleLocalId: feuilleLocalId,
            mobileUuid: const Uuid().v4(),
            compresseurOdooId: _parseInt(row.equipmentId.text),
            qytFuel: _parseDouble(row.quantity.text) ?? 0,
            dateDEqui: _parseHour(row.hrDebut.text),
            dateFEqui: _parseHour(row.hrFin.text),
            dateDRavi: _parseHour(row.hrDebutRavi.text),
            dateFRavi: _parseHour(row.hrFinRavi.text),
          );
        }

        for (final row in filledEmployeeRows) {
          await db.saveLocalFeuilleEmploye(
            feuilleLocalId: feuilleLocalId,
            mobileUuid: const Uuid().v4(),
            employeeOdooId: _parseInt(row.employeeId.text)!,
            fonction: row.fonction.text.trim().isEmpty
                ? null
                : row.fonction.text.trim(),
            observation: row.observation.text.trim().isEmpty
                ? null
                : row.observation.text.trim(),
            dateEmp: dateForage,
            dateDebut: row.hDebut.text.trim().isEmpty
                ? null
                : row.hDebut.text.trim(),
            dateFin: row.hFin.text.trim().isEmpty ? null : row.hFin.text.trim(),
            difference: _parseDouble(row.total.text),
            absent: row.absent,
          );
        }

        for (final row in filledMaterialRows) {
          await db.saveLocalFeuilleMateriel(
            feuilleLocalId: feuilleLocalId,
            mobileUuid: const Uuid().v4(),
            description: row.description.text.trim().isEmpty
                ? null
                : row.description.text.trim(),
            serialNumber: row.serialNumber.text.trim().isEmpty
                ? null
                : row.serialNumber.text.trim(),
            quantity: _parseDouble(row.quantity.text),
            observation: row.observation.text.trim().isEmpty
                ? null
                : row.observation.text.trim(),
            status: row.status.text.trim().isEmpty
                ? null
                : row.status.text.trim(),
          );
        }
      });

      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isEditMode
                ? 'Feuille mise a jour localement'
                : 'Feuille enregistree localement',
          ),
        ),
      );
      Navigator.of(context).pop(true);
    } catch (e) {
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

  String _buildRemarksPayload() {
    final parts = <String>[];
    if (_clientController.text.trim().isNotEmpty) {
      parts.add('Client: ${_clientController.text.trim()}');
    }
    if (_superviseurController.text.trim().isNotEmpty) {
      parts.add('Superviseur: ${_superviseurController.text.trim()}');
    }
    if (_operateurController.text.trim().isNotEmpty) {
      parts.add('Operateur: ${_operateurController.text.trim()}');
    }
    if (_remarksController.text.trim().isNotEmpty) {
      parts.add('Remarques: ${_remarksController.text.trim()}');
    }
    return parts.join(' | ');
  }

  Widget _buildTopInput(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 92,
            child: Text(
              label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
              height: 34,
              color: Colors.white.withValues(alpha: 0.7),
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                readOnly: readOnly,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const SizedBox(
            width: 92,
            child: Text(
              'Projet',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
              height: 34,
              color: Colors.white.withValues(alpha: 0.7),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: _selectedProjectOdooId,
                  hint: const Text(
                    'Ici...',
                    style: TextStyle(fontSize: 12),
                  ),
                  items: _projects
                      .map(
                        (project) => DropdownMenuItem<int>(
                          value: project.odooId,
                          child: Text(
                            project.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedProjectOdooId = value;
                      _projectIdController.text = value?.toString() ?? '';
                      _syncClientFromSelectedProject();
                      _autoFillQuartFromSelectedProject();
                      _normalizeForeuseSelection();
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForeuseDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const SizedBox(
            width: 92,
            child: Text(
              'Foreuse',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
              height: 34,
              color: Colors.white.withValues(alpha: 0.7),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: _selectedForeuseOdooId,
                  hint: const Text(
                    'Ici...',
                    style: TextStyle(fontSize: 12),
                  ),
                  items: _availableForeuses
                      .map(
                        (equipment) => DropdownMenuItem<int>(
                          value: equipment.odooId,
                          child: Text(
                            equipment.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedForeuseOdooId = value;
                      _syncForeuseControllerFromSelection();
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const SizedBox(
            width: 92,
            child: Text(
              'Location',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
              height: 34,
              color: Colors.white.withValues(alpha: 0.7),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: _selectedLocationOdooId,
                  hint: const Text(
                    'Ici...',
                    style: TextStyle(fontSize: 12),
                  ),
                  items: _locations
                      .map(
                        (location) => DropdownMenuItem<int>(
                          value: location.odooId,
                          child: Text(
                            location.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLocationOdooId = value;
                      _syncLocationControllerFromSelection();
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskDropdown(_TimeLogDraft row, {double width = 180}) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: SizedBox(
          height: 40,
          child: DropdownButtonFormField<int>(
            initialValue: row.selectedTaskOdooId,
            isExpanded: true,
            decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            hint: const Text(
              'Tache',
              style: TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
            items: _tasks
                .map(
                  (task) => DropdownMenuItem<int>(
                    value: task.odooId,
                    child: Text(
                      task.libelle,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                row.selectedTaskOdooId = value;
                _syncItemFromTask(row);
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTopData(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 92,
            child: Text(
              label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
              height: 34,
              color: Colors.black.withValues(alpha: 0.05),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(value, style: const TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                _buildProjectDropdown(),
                _buildTopInput('Client', _clientController, readOnly: true),
                _buildTopInput('Quart', _quartController),
                _buildForeuseDropdown(),
                _buildTopInput('Superviseur', _superviseurController),
                _buildTopInput('Operateur', _operateurController),
                _buildTopInput('Fuel meter', _fuelMeterController),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                _buildTopInput('Date', _dateForageController, readOnly: true),
                _buildLocationDropdown(),
                _buildTopData('Total Drill', _totalMeters.toString()),
                _buildTopInput(
                  'Hour meter',
                  _hourMeterController,
                  keyboardType: TextInputType.number,
                ),
                _buildTopData('Drill Hours', _totalHours.toStringAsFixed(2)),
                _buildTopData('Fuel supplied', _totalFuel.toStringAsFixed(2)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white.withValues(alpha: 0.85),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: const Color(0xFFF18E28),
        indicatorColor: const Color(0xFF00C7C9),
        tabs: const [
          Tab(text: 'Lignes de temps'),
          Tab(text: 'Employes'),
          Tab(text: 'Materiels'),
          Tab(text: 'Equip. Aux / Fuel'),
          Tab(text: 'Security'),
          Tab(text: 'Frais'),
        ],
      ),
    );
  }

  Widget _cellInput(
    TextEditingController controller, {
    double width = 120,
    TextInputType? keyboardType,
    ValueChanged<String>? onChanged,
    bool readOnly = false,
  }) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onChanged: onChanged,
          decoration: const InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
          ),
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  Widget _deleteBtn(VoidCallback onTap) {
    return SizedBox(
      width: 44,
      child: IconButton(
        icon: const Icon(
          Icons.delete_outline,
          color: Colors.redAccent,
          size: 18,
        ),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildTableWrapper({
    required List<String> headers,
    required List<Widget> rows,
    required VoidCallback onAdd,
    List<double>? columnWidths,
  }) {
    final widths = columnWidths ?? List<double>.filled(headers.length, 120);
    assert(widths.length == headers.length);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (rows.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.black.withValues(alpha: 0.05),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: List.generate(headers.length, (index) {
                        return SizedBox(
                          width: widths[index],
                          child: Text(
                            headers[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  ...rows,
                ],
              ),
            )
          else
            const Text('Aucune ligne pour le moment.'),
          const SizedBox(height: 12),
          InkWell(
            onTap: onAdd,
            child: const Row(
              children: [
                Icon(Icons.add_circle, color: Color(0xFF00C7C9)),
                SizedBox(width: 8),
                Text(
                  'Ajouter une ligne',
                  style: TextStyle(
                    color: Color(0xFF00C7C9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeLogTab() {
    final rows = _timeLogs.asMap().entries.map((entry) {
      final index = entry.key;
      final row = entry.value;
      return Row(
        children: [
          _cellInput(
            row.debut,
            width: 90,
            keyboardType: TextInputType.datetime,
            onChanged: (_) => setState(() {}),
            readOnly: true,
          ),
          _cellInput(
            row.fin,
            width: 90,
            keyboardType: TextInputType.datetime,
            onChanged: (_) {
              setState(() {
                _recomputeDuration(row);
              });
            },
          ),
          _cellInput(
            row.item,
            width: 70,
            onChanged: (_) {
              setState(() {
                _syncTaskFromItem(row);
              });
            },
          ),
          _cellInput(row.holeNo, width: 80),
          _cellInput(
            row.fromDim,
            width: 70,
            keyboardType: TextInputType.number,
            onChanged: (_) {
              setState(() {
                _recomputeTotalDim(row);
              });
            },
          ),
          _cellInput(
            row.toDim,
            width: 70,
            keyboardType: TextInputType.number,
            onChanged: (_) {
              setState(() {
                _recomputeTotalDim(row);
              });
            },
          ),
          _cellInput(
            row.totalDim,
            width: 70,
            keyboardType: TextInputType.number,
            readOnly: true,
          ),
          _buildTaskDropdown(row, width: 180),
          _cellInput(row.comment, width: 140),
          _cellInput(row.distance, width: 70, keyboardType: TextInputType.number),
          _cellInput(
            row.duration,
            width: 90,
            keyboardType: TextInputType.datetime,
            readOnly: true,
          ),
          _deleteBtn(() => _clearOrRemoveTimeRow(index)),
        ],
      );
    }).toList();
    return _buildTableWrapper(
      headers: const [
        'Debut',
        'Fin',
        'Item',
        'Hole',
        'De',
        'A',
        'Total',
        'Tache',
        'Comment',
        'Dist.',
        'Duree',
        '',
      ],
      columnWidths: const [90, 90, 70, 80, 70, 70, 70, 180, 140, 70, 90, 44],
      rows: rows,
      onAdd: _addTimeRow,
    );
  }

  Widget _buildEmployeeTab() {
    final rows = _employees.asMap().entries.map((entry) {
      final index = entry.key;
      final row = entry.value;
      return Row(
        children: [
          _cellInput(row.employeeId, keyboardType: TextInputType.number),
          _cellInput(row.fonction),
          _cellInput(row.hDebut),
          _cellInput(row.hFin),
          _cellInput(
            row.total,
            keyboardType: TextInputType.datetime,
          ),
          SizedBox(
            width: 120,
            child: CheckboxListTile(
              value: row.absent,
              onChanged: (value) => setState(() => row.absent = value ?? false),
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Abs', style: TextStyle(fontSize: 11)),
            ),
          ),
          _cellInput(row.observation),
          _deleteBtn(() => _clearOrRemoveEmployeeRow(index)),
        ],
      );
    }).toList();
    return _buildTableWrapper(
      headers: const [
        'Employe ID',
        'Fonction',
        'H. Debut',
        'H. Fin',
        'Total',
        'Absent',
        'Obs',
        '',
      ],
      rows: rows,
      onAdd: _addEmployeeRow,
    );
  }

  Widget _buildMaterialTab() {
    final rows = _materials.asMap().entries.map((entry) {
      final index = entry.key;
      final row = entry.value;
      return Row(
        children: [
          _cellInput(row.description),
          _cellInput(row.serialNumber),
          _cellInput(
            row.quantity,
            keyboardType: TextInputType.datetime,
          ),
          _cellInput(row.observation),
          _cellInput(row.status),
          _deleteBtn(() => _clearOrRemoveMaterialRow(index)),
        ],
      );
    }).toList();
    return _buildTableWrapper(
      headers: const [
        'Description',
        'Serie',
        'Quantite',
        'Observation',
        'Status',
        '',
      ],
      rows: rows,
      onAdd: _addMaterialRow,
    );
  }

  Widget _buildFuelTab() {
    final rows = _fuels.asMap().entries.map((entry) {
      final index = entry.key;
      final row = entry.value;
      return Row(
        children: [
          _cellInput(row.equipmentId, keyboardType: TextInputType.number),
          _cellInput(
            row.quantity,
            keyboardType: TextInputType.datetime,
            onChanged: (_) => setState(() {}),
          ),
          _cellInput(
            row.hrDebut,
            keyboardType: TextInputType.datetime,
          ),
          _cellInput(
            row.hrFin,
            keyboardType: TextInputType.datetime,
          ),
          _cellInput(
            row.hrDebutRavi,
            keyboardType: TextInputType.datetime,
          ),
          _cellInput(
            row.hrFinRavi,
            keyboardType: TextInputType.datetime,
          ),
          _deleteBtn(() => _clearOrRemoveFuelRow(index)),
        ],
      );
    }).toList();
    return _buildTableWrapper(
      headers: const [
        'Equipement ID',
        'Qty Fuel',
        'H. D',
        'H. F',
        'H. Debut Ravi',
        'H. Fin Ravi',
        '',
      ],
      rows: rows,
      onAdd: _addFuelRow,
    );
  }

  Widget _buildPlaceholderTab(String title, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFDF8E1), Color(0xFFF5F5F5)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            widget.isEditMode ? 'Modifier feuille' : 'Nouvelle feuille',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          actions: [
            Icon(Icons.logout),
            
          ],
        ),
        body: _initialLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  _buildHeaderSection(),
                  _buildTabBar(),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildTimeLogTab(),
                        _buildEmployeeTab(),
                        _buildMaterialTab(),
                        _buildFuelTab(),
                        _buildPlaceholderTab(
                          'Security',
                          'La saisie security n est pas encore persistee dans SQLite.',
                        ),
                        _buildPlaceholderTab(
                          'Frais',
                          'La saisie frais n est pas encore persistee dans SQLite.',
                        ),
                      ],
                    ),
                  ),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _saveAll,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF18E28),
                        ),
                        child: _loading
                            ? const CircularProgressIndicator()
                            : Text(
                                widget.isEditMode
                                    ? 'Mettre a jour  la feuille'
                                    : 'Enregistrer la feuille',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
