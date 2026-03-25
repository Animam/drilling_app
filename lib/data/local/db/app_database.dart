import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Projects extends Table {
  IntColumn get localId => integer().autoIncrement()();
  IntColumn get odooId => integer().unique()();
  TextColumn get name => text()();
  RealColumn get dateDJ => real().nullable()();
  RealColumn get dateDN => real().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  TextColumn get updatedAt => text().nullable()();
}

class Employees extends Table {
  IntColumn get localId => integer().autoIncrement()();
  IntColumn get odooId => integer().unique()();
  TextColumn get name => text()();
  TextColumn get jobName => text().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  TextColumn get updatedAt => text().nullable()();
}

class Equipments extends Table {
  IntColumn get localId => integer().autoIncrement()();
  IntColumn get odooId => integer().unique()();
  TextColumn get name => text()();
  TextColumn get categoryName => text().nullable()();
  IntColumn get projectOdooId => integer().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  TextColumn get updatedAt => text().nullable()();
}

class Tasks extends Table {
  IntColumn get localId => integer().autoIncrement()();
  IntColumn get odooId => integer().unique()();
  TextColumn get numItem => text().nullable()();
  TextColumn get libelle => text()();
  TextColumn get typeTache => text().nullable()();
  TextColumn get categorieActivity => text().nullable()();
  TextColumn get categorie => text().nullable()();
  TextColumn get typeActivite => text().nullable()();
  TextColumn get updatedAt => text().nullable()();
}

class Locations extends Table {
  IntColumn get localId => integer().autoIncrement()();
  IntColumn get odooId => integer().unique()();
  TextColumn get name => text()();
  TextColumn get updatedAt => text().nullable()();
}

// LazyDatabase _openConnection() {
//   return LazyDatabase(() async {
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File(p.join(dir.path, 'forages_mobile.sqlite'));
//     return NativeDatabase(file);
//   });
// }
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = Directory(r'C:\Users\Parfait-SEDOGO\DevOps\forages_mobile_data');
    await dbFolder.create(recursive: true);

    final file = File(p.join(dbFolder.path, 'forages_mobile.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}




@DriftDatabase(
  tables: [
    Projects,
    Employees,
    Equipments,
    Tasks,
    Locations,
  ],
)



class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> saveProjects(List<Map<String, dynamic>> items) async {
    await batch((batch) {
      batch.insertAll(
        projects,
        items.map((item) {
          return ProjectsCompanion.insert(
            odooId: (item['odoo_id'] as num).toInt(),
            name: item['name']?.toString() ?? '',
            dateDJ: Value((item['date_d_j'] as num?)?.toDouble()),
            dateDN: Value((item['date_d_n'] as num?)?.toDouble()),
            active: Value(item['active'] == true),
            updatedAt: Value(item['updated_at']?.toString()),
          );
        }).toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> saveEmployees(List<Map<String, dynamic>> items) async {
    await batch((batch) {
      batch.insertAll(
        employees,
        items.map((item) {
          return EmployeesCompanion.insert(
            odooId: (item['odoo_id'] as num).toInt(),
            name: item['name']?.toString() ?? '',
            jobName: Value(item['job_name']?.toString()),
            active: Value(item['active'] == true),
            updatedAt: Value(item['updated_at']?.toString()),
          );
        }).toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> saveEquipments(List<Map<String, dynamic>> items) async {
    await batch((batch) {
      batch.insertAll(
        equipments,
        items.map((item) {
          return EquipmentsCompanion.insert(
            odooId: (item['odoo_id'] as num).toInt(),
            name: item['name']?.toString() ?? '',
            categoryName: Value(item['category_name']?.toString()),
            projectOdooId: Value((item['project_odoo_id'] as num?)?.toInt()),
            active: Value(item['active'] == true),
            updatedAt: Value(item['updated_at']?.toString()),
          );
        }).toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> saveTasks(List<Map<String, dynamic>> items) async {
    await batch((batch) {
      batch.insertAll(
        tasks,
        items.map((item) {
          return TasksCompanion.insert(
            odooId: (item['odoo_id'] as num).toInt(),
            numItem: Value(item['num_item']?.toString()),
            libelle: item['libelle']?.toString() ?? '',
            typeTache: Value(item['type_tache']?.toString()),
            categorieActivity: Value(item['categorie_activity']?.toString()),
            categorie: Value(item['categorie']?.toString()),
            typeActivite: Value(item['type_activite']?.toString()),
            updatedAt: Value(item['updated_at']?.toString()),
          );
        }).toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> saveLocations(List<Map<String, dynamic>> items) async {
    await batch((batch) {
      batch.insertAll(
        locations,
        items.map((item) {
          return LocationsCompanion.insert(
            odooId: (item['odoo_id'] as num).toInt(),
            name: item['name']?.toString() ?? '',
            updatedAt: Value(item['updated_at']?.toString()),
          );
        }).toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }




  Future<List<Project>> getAllProjects() => select(projects).get();
  Future<List<Employee>> getAllEmployees() => select(employees).get();
  Future<List<Equipment>> getAllEquipments() => select(equipments).get();
  Future<List<Task>> getAllTasks() => select(tasks).get();
  Future<List<Location>> getAllLocations() => select(locations).get();

  

  }

