// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _odooIdMeta = const VerificationMeta('odooId');
  @override
  late final GeneratedColumn<int> odooId = GeneratedColumn<int>(
    'odoo_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateDJMeta = const VerificationMeta('dateDJ');
  @override
  late final GeneratedColumn<double> dateDJ = GeneratedColumn<double>(
    'date_d_j',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateDNMeta = const VerificationMeta('dateDN');
  @override
  late final GeneratedColumn<double> dateDN = GeneratedColumn<double>(
    'date_d_n',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    odooId,
    name,
    dateDJ,
    dateDN,
    active,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Project> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('odoo_id')) {
      context.handle(
        _odooIdMeta,
        odooId.isAcceptableOrUnknown(data['odoo_id']!, _odooIdMeta),
      );
    } else if (isInserting) {
      context.missing(_odooIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('date_d_j')) {
      context.handle(
        _dateDJMeta,
        dateDJ.isAcceptableOrUnknown(data['date_d_j']!, _dateDJMeta),
      );
    }
    if (data.containsKey('date_d_n')) {
      context.handle(
        _dateDNMeta,
        dateDN.isAcceptableOrUnknown(data['date_d_n']!, _dateDNMeta),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      odooId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odoo_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      dateDJ: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}date_d_j'],
      ),
      dateDN: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}date_d_n'],
      ),
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

class Project extends DataClass implements Insertable<Project> {
  final int localId;
  final int odooId;
  final String name;
  final double? dateDJ;
  final double? dateDN;
  final bool active;
  final String? updatedAt;
  const Project({
    required this.localId,
    required this.odooId,
    required this.name,
    this.dateDJ,
    this.dateDN,
    required this.active,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    map['odoo_id'] = Variable<int>(odooId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || dateDJ != null) {
      map['date_d_j'] = Variable<double>(dateDJ);
    }
    if (!nullToAbsent || dateDN != null) {
      map['date_d_n'] = Variable<double>(dateDN);
    }
    map['active'] = Variable<bool>(active);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      localId: Value(localId),
      odooId: Value(odooId),
      name: Value(name),
      dateDJ: dateDJ == null && nullToAbsent
          ? const Value.absent()
          : Value(dateDJ),
      dateDN: dateDN == null && nullToAbsent
          ? const Value.absent()
          : Value(dateDN),
      active: Value(active),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Project.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      localId: serializer.fromJson<int>(json['localId']),
      odooId: serializer.fromJson<int>(json['odooId']),
      name: serializer.fromJson<String>(json['name']),
      dateDJ: serializer.fromJson<double?>(json['dateDJ']),
      dateDN: serializer.fromJson<double?>(json['dateDN']),
      active: serializer.fromJson<bool>(json['active']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'odooId': serializer.toJson<int>(odooId),
      'name': serializer.toJson<String>(name),
      'dateDJ': serializer.toJson<double?>(dateDJ),
      'dateDN': serializer.toJson<double?>(dateDN),
      'active': serializer.toJson<bool>(active),
      'updatedAt': serializer.toJson<String?>(updatedAt),
    };
  }

  Project copyWith({
    int? localId,
    int? odooId,
    String? name,
    Value<double?> dateDJ = const Value.absent(),
    Value<double?> dateDN = const Value.absent(),
    bool? active,
    Value<String?> updatedAt = const Value.absent(),
  }) => Project(
    localId: localId ?? this.localId,
    odooId: odooId ?? this.odooId,
    name: name ?? this.name,
    dateDJ: dateDJ.present ? dateDJ.value : this.dateDJ,
    dateDN: dateDN.present ? dateDN.value : this.dateDN,
    active: active ?? this.active,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Project copyWithCompanion(ProjectsCompanion data) {
    return Project(
      localId: data.localId.present ? data.localId.value : this.localId,
      odooId: data.odooId.present ? data.odooId.value : this.odooId,
      name: data.name.present ? data.name.value : this.name,
      dateDJ: data.dateDJ.present ? data.dateDJ.value : this.dateDJ,
      dateDN: data.dateDN.present ? data.dateDN.value : this.dateDN,
      active: data.active.present ? data.active.value : this.active,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('localId: $localId, ')
          ..write('odooId: $odooId, ')
          ..write('name: $name, ')
          ..write('dateDJ: $dateDJ, ')
          ..write('dateDN: $dateDN, ')
          ..write('active: $active, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(localId, odooId, name, dateDJ, dateDN, active, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.localId == this.localId &&
          other.odooId == this.odooId &&
          other.name == this.name &&
          other.dateDJ == this.dateDJ &&
          other.dateDN == this.dateDN &&
          other.active == this.active &&
          other.updatedAt == this.updatedAt);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<int> localId;
  final Value<int> odooId;
  final Value<String> name;
  final Value<double?> dateDJ;
  final Value<double?> dateDN;
  final Value<bool> active;
  final Value<String?> updatedAt;
  const ProjectsCompanion({
    this.localId = const Value.absent(),
    this.odooId = const Value.absent(),
    this.name = const Value.absent(),
    this.dateDJ = const Value.absent(),
    this.dateDN = const Value.absent(),
    this.active = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProjectsCompanion.insert({
    this.localId = const Value.absent(),
    required int odooId,
    required String name,
    this.dateDJ = const Value.absent(),
    this.dateDN = const Value.absent(),
    this.active = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : odooId = Value(odooId),
       name = Value(name);
  static Insertable<Project> custom({
    Expression<int>? localId,
    Expression<int>? odooId,
    Expression<String>? name,
    Expression<double>? dateDJ,
    Expression<double>? dateDN,
    Expression<bool>? active,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (odooId != null) 'odoo_id': odooId,
      if (name != null) 'name': name,
      if (dateDJ != null) 'date_d_j': dateDJ,
      if (dateDN != null) 'date_d_n': dateDN,
      if (active != null) 'active': active,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProjectsCompanion copyWith({
    Value<int>? localId,
    Value<int>? odooId,
    Value<String>? name,
    Value<double?>? dateDJ,
    Value<double?>? dateDN,
    Value<bool>? active,
    Value<String?>? updatedAt,
  }) {
    return ProjectsCompanion(
      localId: localId ?? this.localId,
      odooId: odooId ?? this.odooId,
      name: name ?? this.name,
      dateDJ: dateDJ ?? this.dateDJ,
      dateDN: dateDN ?? this.dateDN,
      active: active ?? this.active,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (odooId.present) {
      map['odoo_id'] = Variable<int>(odooId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dateDJ.present) {
      map['date_d_j'] = Variable<double>(dateDJ.value);
    }
    if (dateDN.present) {
      map['date_d_n'] = Variable<double>(dateDN.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('localId: $localId, ')
          ..write('odooId: $odooId, ')
          ..write('name: $name, ')
          ..write('dateDJ: $dateDJ, ')
          ..write('dateDN: $dateDN, ')
          ..write('active: $active, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $EmployeesTable extends Employees
    with TableInfo<$EmployeesTable, Employee> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _odooIdMeta = const VerificationMeta('odooId');
  @override
  late final GeneratedColumn<int> odooId = GeneratedColumn<int>(
    'odoo_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jobNameMeta = const VerificationMeta(
    'jobName',
  );
  @override
  late final GeneratedColumn<String> jobName = GeneratedColumn<String>(
    'job_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    odooId,
    name,
    jobName,
    active,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employees';
  @override
  VerificationContext validateIntegrity(
    Insertable<Employee> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('odoo_id')) {
      context.handle(
        _odooIdMeta,
        odooId.isAcceptableOrUnknown(data['odoo_id']!, _odooIdMeta),
      );
    } else if (isInserting) {
      context.missing(_odooIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('job_name')) {
      context.handle(
        _jobNameMeta,
        jobName.isAcceptableOrUnknown(data['job_name']!, _jobNameMeta),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  Employee map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Employee(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      odooId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odoo_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      jobName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_name'],
      ),
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $EmployeesTable createAlias(String alias) {
    return $EmployeesTable(attachedDatabase, alias);
  }
}

class Employee extends DataClass implements Insertable<Employee> {
  final int localId;
  final int odooId;
  final String name;
  final String? jobName;
  final bool active;
  final String? updatedAt;
  const Employee({
    required this.localId,
    required this.odooId,
    required this.name,
    this.jobName,
    required this.active,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    map['odoo_id'] = Variable<int>(odooId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || jobName != null) {
      map['job_name'] = Variable<String>(jobName);
    }
    map['active'] = Variable<bool>(active);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  EmployeesCompanion toCompanion(bool nullToAbsent) {
    return EmployeesCompanion(
      localId: Value(localId),
      odooId: Value(odooId),
      name: Value(name),
      jobName: jobName == null && nullToAbsent
          ? const Value.absent()
          : Value(jobName),
      active: Value(active),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Employee.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Employee(
      localId: serializer.fromJson<int>(json['localId']),
      odooId: serializer.fromJson<int>(json['odooId']),
      name: serializer.fromJson<String>(json['name']),
      jobName: serializer.fromJson<String?>(json['jobName']),
      active: serializer.fromJson<bool>(json['active']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'odooId': serializer.toJson<int>(odooId),
      'name': serializer.toJson<String>(name),
      'jobName': serializer.toJson<String?>(jobName),
      'active': serializer.toJson<bool>(active),
      'updatedAt': serializer.toJson<String?>(updatedAt),
    };
  }

  Employee copyWith({
    int? localId,
    int? odooId,
    String? name,
    Value<String?> jobName = const Value.absent(),
    bool? active,
    Value<String?> updatedAt = const Value.absent(),
  }) => Employee(
    localId: localId ?? this.localId,
    odooId: odooId ?? this.odooId,
    name: name ?? this.name,
    jobName: jobName.present ? jobName.value : this.jobName,
    active: active ?? this.active,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Employee copyWithCompanion(EmployeesCompanion data) {
    return Employee(
      localId: data.localId.present ? data.localId.value : this.localId,
      odooId: data.odooId.present ? data.odooId.value : this.odooId,
      name: data.name.present ? data.name.value : this.name,
      jobName: data.jobName.present ? data.jobName.value : this.jobName,
      active: data.active.present ? data.active.value : this.active,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Employee(')
          ..write('localId: $localId, ')
          ..write('odooId: $odooId, ')
          ..write('name: $name, ')
          ..write('jobName: $jobName, ')
          ..write('active: $active, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(localId, odooId, name, jobName, active, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Employee &&
          other.localId == this.localId &&
          other.odooId == this.odooId &&
          other.name == this.name &&
          other.jobName == this.jobName &&
          other.active == this.active &&
          other.updatedAt == this.updatedAt);
}

class EmployeesCompanion extends UpdateCompanion<Employee> {
  final Value<int> localId;
  final Value<int> odooId;
  final Value<String> name;
  final Value<String?> jobName;
  final Value<bool> active;
  final Value<String?> updatedAt;
  const EmployeesCompanion({
    this.localId = const Value.absent(),
    this.odooId = const Value.absent(),
    this.name = const Value.absent(),
    this.jobName = const Value.absent(),
    this.active = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  EmployeesCompanion.insert({
    this.localId = const Value.absent(),
    required int odooId,
    required String name,
    this.jobName = const Value.absent(),
    this.active = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : odooId = Value(odooId),
       name = Value(name);
  static Insertable<Employee> custom({
    Expression<int>? localId,
    Expression<int>? odooId,
    Expression<String>? name,
    Expression<String>? jobName,
    Expression<bool>? active,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (odooId != null) 'odoo_id': odooId,
      if (name != null) 'name': name,
      if (jobName != null) 'job_name': jobName,
      if (active != null) 'active': active,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  EmployeesCompanion copyWith({
    Value<int>? localId,
    Value<int>? odooId,
    Value<String>? name,
    Value<String?>? jobName,
    Value<bool>? active,
    Value<String?>? updatedAt,
  }) {
    return EmployeesCompanion(
      localId: localId ?? this.localId,
      odooId: odooId ?? this.odooId,
      name: name ?? this.name,
      jobName: jobName ?? this.jobName,
      active: active ?? this.active,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (odooId.present) {
      map['odoo_id'] = Variable<int>(odooId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (jobName.present) {
      map['job_name'] = Variable<String>(jobName.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeesCompanion(')
          ..write('localId: $localId, ')
          ..write('odooId: $odooId, ')
          ..write('name: $name, ')
          ..write('jobName: $jobName, ')
          ..write('active: $active, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $EquipmentsTable extends Equipments
    with TableInfo<$EquipmentsTable, Equipment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EquipmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _odooIdMeta = const VerificationMeta('odooId');
  @override
  late final GeneratedColumn<int> odooId = GeneratedColumn<int>(
    'odoo_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryNameMeta = const VerificationMeta(
    'categoryName',
  );
  @override
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
    'category_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectOdooIdMeta = const VerificationMeta(
    'projectOdooId',
  );
  @override
  late final GeneratedColumn<int> projectOdooId = GeneratedColumn<int>(
    'project_odoo_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    odooId,
    name,
    categoryName,
    projectOdooId,
    active,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Equipment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('odoo_id')) {
      context.handle(
        _odooIdMeta,
        odooId.isAcceptableOrUnknown(data['odoo_id']!, _odooIdMeta),
      );
    } else if (isInserting) {
      context.missing(_odooIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category_name')) {
      context.handle(
        _categoryNameMeta,
        categoryName.isAcceptableOrUnknown(
          data['category_name']!,
          _categoryNameMeta,
        ),
      );
    }
    if (data.containsKey('project_odoo_id')) {
      context.handle(
        _projectOdooIdMeta,
        projectOdooId.isAcceptableOrUnknown(
          data['project_odoo_id']!,
          _projectOdooIdMeta,
        ),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  Equipment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Equipment(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      odooId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odoo_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      categoryName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_name'],
      ),
      projectOdooId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}project_odoo_id'],
      ),
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $EquipmentsTable createAlias(String alias) {
    return $EquipmentsTable(attachedDatabase, alias);
  }
}

class Equipment extends DataClass implements Insertable<Equipment> {
  final int localId;
  final int odooId;
  final String name;
  final String? categoryName;
  final int? projectOdooId;
  final bool active;
  final String? updatedAt;
  const Equipment({
    required this.localId,
    required this.odooId,
    required this.name,
    this.categoryName,
    this.projectOdooId,
    required this.active,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    map['odoo_id'] = Variable<int>(odooId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || categoryName != null) {
      map['category_name'] = Variable<String>(categoryName);
    }
    if (!nullToAbsent || projectOdooId != null) {
      map['project_odoo_id'] = Variable<int>(projectOdooId);
    }
    map['active'] = Variable<bool>(active);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  EquipmentsCompanion toCompanion(bool nullToAbsent) {
    return EquipmentsCompanion(
      localId: Value(localId),
      odooId: Value(odooId),
      name: Value(name),
      categoryName: categoryName == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryName),
      projectOdooId: projectOdooId == null && nullToAbsent
          ? const Value.absent()
          : Value(projectOdooId),
      active: Value(active),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Equipment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Equipment(
      localId: serializer.fromJson<int>(json['localId']),
      odooId: serializer.fromJson<int>(json['odooId']),
      name: serializer.fromJson<String>(json['name']),
      categoryName: serializer.fromJson<String?>(json['categoryName']),
      projectOdooId: serializer.fromJson<int?>(json['projectOdooId']),
      active: serializer.fromJson<bool>(json['active']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'odooId': serializer.toJson<int>(odooId),
      'name': serializer.toJson<String>(name),
      'categoryName': serializer.toJson<String?>(categoryName),
      'projectOdooId': serializer.toJson<int?>(projectOdooId),
      'active': serializer.toJson<bool>(active),
      'updatedAt': serializer.toJson<String?>(updatedAt),
    };
  }

  Equipment copyWith({
    int? localId,
    int? odooId,
    String? name,
    Value<String?> categoryName = const Value.absent(),
    Value<int?> projectOdooId = const Value.absent(),
    bool? active,
    Value<String?> updatedAt = const Value.absent(),
  }) => Equipment(
    localId: localId ?? this.localId,
    odooId: odooId ?? this.odooId,
    name: name ?? this.name,
    categoryName: categoryName.present ? categoryName.value : this.categoryName,
    projectOdooId: projectOdooId.present
        ? projectOdooId.value
        : this.projectOdooId,
    active: active ?? this.active,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Equipment copyWithCompanion(EquipmentsCompanion data) {
    return Equipment(
      localId: data.localId.present ? data.localId.value : this.localId,
      odooId: data.odooId.present ? data.odooId.value : this.odooId,
      name: data.name.present ? data.name.value : this.name,
      categoryName: data.categoryName.present
          ? data.categoryName.value
          : this.categoryName,
      projectOdooId: data.projectOdooId.present
          ? data.projectOdooId.value
          : this.projectOdooId,
      active: data.active.present ? data.active.value : this.active,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Equipment(')
          ..write('localId: $localId, ')
          ..write('odooId: $odooId, ')
          ..write('name: $name, ')
          ..write('categoryName: $categoryName, ')
          ..write('projectOdooId: $projectOdooId, ')
          ..write('active: $active, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    odooId,
    name,
    categoryName,
    projectOdooId,
    active,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Equipment &&
          other.localId == this.localId &&
          other.odooId == this.odooId &&
          other.name == this.name &&
          other.categoryName == this.categoryName &&
          other.projectOdooId == this.projectOdooId &&
          other.active == this.active &&
          other.updatedAt == this.updatedAt);
}

class EquipmentsCompanion extends UpdateCompanion<Equipment> {
  final Value<int> localId;
  final Value<int> odooId;
  final Value<String> name;
  final Value<String?> categoryName;
  final Value<int?> projectOdooId;
  final Value<bool> active;
  final Value<String?> updatedAt;
  const EquipmentsCompanion({
    this.localId = const Value.absent(),
    this.odooId = const Value.absent(),
    this.name = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.projectOdooId = const Value.absent(),
    this.active = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  EquipmentsCompanion.insert({
    this.localId = const Value.absent(),
    required int odooId,
    required String name,
    this.categoryName = const Value.absent(),
    this.projectOdooId = const Value.absent(),
    this.active = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : odooId = Value(odooId),
       name = Value(name);
  static Insertable<Equipment> custom({
    Expression<int>? localId,
    Expression<int>? odooId,
    Expression<String>? name,
    Expression<String>? categoryName,
    Expression<int>? projectOdooId,
    Expression<bool>? active,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (odooId != null) 'odoo_id': odooId,
      if (name != null) 'name': name,
      if (categoryName != null) 'category_name': categoryName,
      if (projectOdooId != null) 'project_odoo_id': projectOdooId,
      if (active != null) 'active': active,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  EquipmentsCompanion copyWith({
    Value<int>? localId,
    Value<int>? odooId,
    Value<String>? name,
    Value<String?>? categoryName,
    Value<int?>? projectOdooId,
    Value<bool>? active,
    Value<String?>? updatedAt,
  }) {
    return EquipmentsCompanion(
      localId: localId ?? this.localId,
      odooId: odooId ?? this.odooId,
      name: name ?? this.name,
      categoryName: categoryName ?? this.categoryName,
      projectOdooId: projectOdooId ?? this.projectOdooId,
      active: active ?? this.active,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (odooId.present) {
      map['odoo_id'] = Variable<int>(odooId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    if (projectOdooId.present) {
      map['project_odoo_id'] = Variable<int>(projectOdooId.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentsCompanion(')
          ..write('localId: $localId, ')
          ..write('odooId: $odooId, ')
          ..write('name: $name, ')
          ..write('categoryName: $categoryName, ')
          ..write('projectOdooId: $projectOdooId, ')
          ..write('active: $active, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _odooIdMeta = const VerificationMeta('odooId');
  @override
  late final GeneratedColumn<int> odooId = GeneratedColumn<int>(
    'odoo_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _numItemMeta = const VerificationMeta(
    'numItem',
  );
  @override
  late final GeneratedColumn<String> numItem = GeneratedColumn<String>(
    'num_item',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _libelleMeta = const VerificationMeta(
    'libelle',
  );
  @override
  late final GeneratedColumn<String> libelle = GeneratedColumn<String>(
    'libelle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeTacheMeta = const VerificationMeta(
    'typeTache',
  );
  @override
  late final GeneratedColumn<String> typeTache = GeneratedColumn<String>(
    'type_tache',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categorieActivityMeta = const VerificationMeta(
    'categorieActivity',
  );
  @override
  late final GeneratedColumn<String> categorieActivity =
      GeneratedColumn<String>(
        'categorie_activity',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _categorieMeta = const VerificationMeta(
    'categorie',
  );
  @override
  late final GeneratedColumn<String> categorie = GeneratedColumn<String>(
    'categorie',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeActiviteMeta = const VerificationMeta(
    'typeActivite',
  );
  @override
  late final GeneratedColumn<String> typeActivite = GeneratedColumn<String>(
    'type_activite',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    odooId,
    numItem,
    libelle,
    typeTache,
    categorieActivity,
    categorie,
    typeActivite,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('odoo_id')) {
      context.handle(
        _odooIdMeta,
        odooId.isAcceptableOrUnknown(data['odoo_id']!, _odooIdMeta),
      );
    } else if (isInserting) {
      context.missing(_odooIdMeta);
    }
    if (data.containsKey('num_item')) {
      context.handle(
        _numItemMeta,
        numItem.isAcceptableOrUnknown(data['num_item']!, _numItemMeta),
      );
    }
    if (data.containsKey('libelle')) {
      context.handle(
        _libelleMeta,
        libelle.isAcceptableOrUnknown(data['libelle']!, _libelleMeta),
      );
    } else if (isInserting) {
      context.missing(_libelleMeta);
    }
    if (data.containsKey('type_tache')) {
      context.handle(
        _typeTacheMeta,
        typeTache.isAcceptableOrUnknown(data['type_tache']!, _typeTacheMeta),
      );
    }
    if (data.containsKey('categorie_activity')) {
      context.handle(
        _categorieActivityMeta,
        categorieActivity.isAcceptableOrUnknown(
          data['categorie_activity']!,
          _categorieActivityMeta,
        ),
      );
    }
    if (data.containsKey('categorie')) {
      context.handle(
        _categorieMeta,
        categorie.isAcceptableOrUnknown(data['categorie']!, _categorieMeta),
      );
    }
    if (data.containsKey('type_activite')) {
      context.handle(
        _typeActiviteMeta,
        typeActivite.isAcceptableOrUnknown(
          data['type_activite']!,
          _typeActiviteMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      odooId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odoo_id'],
      )!,
      numItem: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}num_item'],
      ),
      libelle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}libelle'],
      )!,
      typeTache: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_tache'],
      ),
      categorieActivity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categorie_activity'],
      ),
      categorie: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categorie'],
      ),
      typeActivite: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_activite'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int localId;
  final int odooId;
  final String? numItem;
  final String libelle;
  final String? typeTache;
  final String? categorieActivity;
  final String? categorie;
  final String? typeActivite;
  final String? updatedAt;
  const Task({
    required this.localId,
    required this.odooId,
    this.numItem,
    required this.libelle,
    this.typeTache,
    this.categorieActivity,
    this.categorie,
    this.typeActivite,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    map['odoo_id'] = Variable<int>(odooId);
    if (!nullToAbsent || numItem != null) {
      map['num_item'] = Variable<String>(numItem);
    }
    map['libelle'] = Variable<String>(libelle);
    if (!nullToAbsent || typeTache != null) {
      map['type_tache'] = Variable<String>(typeTache);
    }
    if (!nullToAbsent || categorieActivity != null) {
      map['categorie_activity'] = Variable<String>(categorieActivity);
    }
    if (!nullToAbsent || categorie != null) {
      map['categorie'] = Variable<String>(categorie);
    }
    if (!nullToAbsent || typeActivite != null) {
      map['type_activite'] = Variable<String>(typeActivite);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      localId: Value(localId),
      odooId: Value(odooId),
      numItem: numItem == null && nullToAbsent
          ? const Value.absent()
          : Value(numItem),
      libelle: Value(libelle),
      typeTache: typeTache == null && nullToAbsent
          ? const Value.absent()
          : Value(typeTache),
      categorieActivity: categorieActivity == null && nullToAbsent
          ? const Value.absent()
          : Value(categorieActivity),
      categorie: categorie == null && nullToAbsent
          ? const Value.absent()
          : Value(categorie),
      typeActivite: typeActivite == null && nullToAbsent
          ? const Value.absent()
          : Value(typeActivite),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      localId: serializer.fromJson<int>(json['localId']),
      odooId: serializer.fromJson<int>(json['odooId']),
      numItem: serializer.fromJson<String?>(json['numItem']),
      libelle: serializer.fromJson<String>(json['libelle']),
      typeTache: serializer.fromJson<String?>(json['typeTache']),
      categorieActivity: serializer.fromJson<String?>(
        json['categorieActivity'],
      ),
      categorie: serializer.fromJson<String?>(json['categorie']),
      typeActivite: serializer.fromJson<String?>(json['typeActivite']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'odooId': serializer.toJson<int>(odooId),
      'numItem': serializer.toJson<String?>(numItem),
      'libelle': serializer.toJson<String>(libelle),
      'typeTache': serializer.toJson<String?>(typeTache),
      'categorieActivity': serializer.toJson<String?>(categorieActivity),
      'categorie': serializer.toJson<String?>(categorie),
      'typeActivite': serializer.toJson<String?>(typeActivite),
      'updatedAt': serializer.toJson<String?>(updatedAt),
    };
  }

  Task copyWith({
    int? localId,
    int? odooId,
    Value<String?> numItem = const Value.absent(),
    String? libelle,
    Value<String?> typeTache = const Value.absent(),
    Value<String?> categorieActivity = const Value.absent(),
    Value<String?> categorie = const Value.absent(),
    Value<String?> typeActivite = const Value.absent(),
    Value<String?> updatedAt = const Value.absent(),
  }) => Task(
    localId: localId ?? this.localId,
    odooId: odooId ?? this.odooId,
    numItem: numItem.present ? numItem.value : this.numItem,
    libelle: libelle ?? this.libelle,
    typeTache: typeTache.present ? typeTache.value : this.typeTache,
    categorieActivity: categorieActivity.present
        ? categorieActivity.value
        : this.categorieActivity,
    categorie: categorie.present ? categorie.value : this.categorie,
    typeActivite: typeActivite.present ? typeActivite.value : this.typeActivite,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      localId: data.localId.present ? data.localId.value : this.localId,
      odooId: data.odooId.present ? data.odooId.value : this.odooId,
      numItem: data.numItem.present ? data.numItem.value : this.numItem,
      libelle: data.libelle.present ? data.libelle.value : this.libelle,
      typeTache: data.typeTache.present ? data.typeTache.value : this.typeTache,
      categorieActivity: data.categorieActivity.present
          ? data.categorieActivity.value
          : this.categorieActivity,
      categorie: data.categorie.present ? data.categorie.value : this.categorie,
      typeActivite: data.typeActivite.present
          ? data.typeActivite.value
          : this.typeActivite,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('localId: $localId, ')
          ..write('odooId: $odooId, ')
          ..write('numItem: $numItem, ')
          ..write('libelle: $libelle, ')
          ..write('typeTache: $typeTache, ')
          ..write('categorieActivity: $categorieActivity, ')
          ..write('categorie: $categorie, ')
          ..write('typeActivite: $typeActivite, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    odooId,
    numItem,
    libelle,
    typeTache,
    categorieActivity,
    categorie,
    typeActivite,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.localId == this.localId &&
          other.odooId == this.odooId &&
          other.numItem == this.numItem &&
          other.libelle == this.libelle &&
          other.typeTache == this.typeTache &&
          other.categorieActivity == this.categorieActivity &&
          other.categorie == this.categorie &&
          other.typeActivite == this.typeActivite &&
          other.updatedAt == this.updatedAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> localId;
  final Value<int> odooId;
  final Value<String?> numItem;
  final Value<String> libelle;
  final Value<String?> typeTache;
  final Value<String?> categorieActivity;
  final Value<String?> categorie;
  final Value<String?> typeActivite;
  final Value<String?> updatedAt;
  const TasksCompanion({
    this.localId = const Value.absent(),
    this.odooId = const Value.absent(),
    this.numItem = const Value.absent(),
    this.libelle = const Value.absent(),
    this.typeTache = const Value.absent(),
    this.categorieActivity = const Value.absent(),
    this.categorie = const Value.absent(),
    this.typeActivite = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TasksCompanion.insert({
    this.localId = const Value.absent(),
    required int odooId,
    this.numItem = const Value.absent(),
    required String libelle,
    this.typeTache = const Value.absent(),
    this.categorieActivity = const Value.absent(),
    this.categorie = const Value.absent(),
    this.typeActivite = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : odooId = Value(odooId),
       libelle = Value(libelle);
  static Insertable<Task> custom({
    Expression<int>? localId,
    Expression<int>? odooId,
    Expression<String>? numItem,
    Expression<String>? libelle,
    Expression<String>? typeTache,
    Expression<String>? categorieActivity,
    Expression<String>? categorie,
    Expression<String>? typeActivite,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (odooId != null) 'odoo_id': odooId,
      if (numItem != null) 'num_item': numItem,
      if (libelle != null) 'libelle': libelle,
      if (typeTache != null) 'type_tache': typeTache,
      if (categorieActivity != null) 'categorie_activity': categorieActivity,
      if (categorie != null) 'categorie': categorie,
      if (typeActivite != null) 'type_activite': typeActivite,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TasksCompanion copyWith({
    Value<int>? localId,
    Value<int>? odooId,
    Value<String?>? numItem,
    Value<String>? libelle,
    Value<String?>? typeTache,
    Value<String?>? categorieActivity,
    Value<String?>? categorie,
    Value<String?>? typeActivite,
    Value<String?>? updatedAt,
  }) {
    return TasksCompanion(
      localId: localId ?? this.localId,
      odooId: odooId ?? this.odooId,
      numItem: numItem ?? this.numItem,
      libelle: libelle ?? this.libelle,
      typeTache: typeTache ?? this.typeTache,
      categorieActivity: categorieActivity ?? this.categorieActivity,
      categorie: categorie ?? this.categorie,
      typeActivite: typeActivite ?? this.typeActivite,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (odooId.present) {
      map['odoo_id'] = Variable<int>(odooId.value);
    }
    if (numItem.present) {
      map['num_item'] = Variable<String>(numItem.value);
    }
    if (libelle.present) {
      map['libelle'] = Variable<String>(libelle.value);
    }
    if (typeTache.present) {
      map['type_tache'] = Variable<String>(typeTache.value);
    }
    if (categorieActivity.present) {
      map['categorie_activity'] = Variable<String>(categorieActivity.value);
    }
    if (categorie.present) {
      map['categorie'] = Variable<String>(categorie.value);
    }
    if (typeActivite.present) {
      map['type_activite'] = Variable<String>(typeActivite.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('localId: $localId, ')
          ..write('odooId: $odooId, ')
          ..write('numItem: $numItem, ')
          ..write('libelle: $libelle, ')
          ..write('typeTache: $typeTache, ')
          ..write('categorieActivity: $categorieActivity, ')
          ..write('categorie: $categorie, ')
          ..write('typeActivite: $typeActivite, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LocationsTable extends Locations
    with TableInfo<$LocationsTable, Location> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _odooIdMeta = const VerificationMeta('odooId');
  @override
  late final GeneratedColumn<int> odooId = GeneratedColumn<int>(
    'odoo_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [localId, odooId, name, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'locations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Location> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('odoo_id')) {
      context.handle(
        _odooIdMeta,
        odooId.isAcceptableOrUnknown(data['odoo_id']!, _odooIdMeta),
      );
    } else if (isInserting) {
      context.missing(_odooIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  Location map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Location(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      odooId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odoo_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $LocationsTable createAlias(String alias) {
    return $LocationsTable(attachedDatabase, alias);
  }
}

class Location extends DataClass implements Insertable<Location> {
  final int localId;
  final int odooId;
  final String name;
  final String? updatedAt;
  const Location({
    required this.localId,
    required this.odooId,
    required this.name,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    map['odoo_id'] = Variable<int>(odooId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  LocationsCompanion toCompanion(bool nullToAbsent) {
    return LocationsCompanion(
      localId: Value(localId),
      odooId: Value(odooId),
      name: Value(name),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Location.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Location(
      localId: serializer.fromJson<int>(json['localId']),
      odooId: serializer.fromJson<int>(json['odooId']),
      name: serializer.fromJson<String>(json['name']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'odooId': serializer.toJson<int>(odooId),
      'name': serializer.toJson<String>(name),
      'updatedAt': serializer.toJson<String?>(updatedAt),
    };
  }

  Location copyWith({
    int? localId,
    int? odooId,
    String? name,
    Value<String?> updatedAt = const Value.absent(),
  }) => Location(
    localId: localId ?? this.localId,
    odooId: odooId ?? this.odooId,
    name: name ?? this.name,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Location copyWithCompanion(LocationsCompanion data) {
    return Location(
      localId: data.localId.present ? data.localId.value : this.localId,
      odooId: data.odooId.present ? data.odooId.value : this.odooId,
      name: data.name.present ? data.name.value : this.name,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Location(')
          ..write('localId: $localId, ')
          ..write('odooId: $odooId, ')
          ..write('name: $name, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(localId, odooId, name, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location &&
          other.localId == this.localId &&
          other.odooId == this.odooId &&
          other.name == this.name &&
          other.updatedAt == this.updatedAt);
}

class LocationsCompanion extends UpdateCompanion<Location> {
  final Value<int> localId;
  final Value<int> odooId;
  final Value<String> name;
  final Value<String?> updatedAt;
  const LocationsCompanion({
    this.localId = const Value.absent(),
    this.odooId = const Value.absent(),
    this.name = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LocationsCompanion.insert({
    this.localId = const Value.absent(),
    required int odooId,
    required String name,
    this.updatedAt = const Value.absent(),
  }) : odooId = Value(odooId),
       name = Value(name);
  static Insertable<Location> custom({
    Expression<int>? localId,
    Expression<int>? odooId,
    Expression<String>? name,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (odooId != null) 'odoo_id': odooId,
      if (name != null) 'name': name,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LocationsCompanion copyWith({
    Value<int>? localId,
    Value<int>? odooId,
    Value<String>? name,
    Value<String?>? updatedAt,
  }) {
    return LocationsCompanion(
      localId: localId ?? this.localId,
      odooId: odooId ?? this.odooId,
      name: name ?? this.name,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (odooId.present) {
      map['odoo_id'] = Variable<int>(odooId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationsCompanion(')
          ..write('localId: $localId, ')
          ..write('odooId: $odooId, ')
          ..write('name: $name, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $EmployeesTable employees = $EmployeesTable(this);
  late final $EquipmentsTable equipments = $EquipmentsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $LocationsTable locations = $LocationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    projects,
    employees,
    equipments,
    tasks,
    locations,
  ];
}

typedef $$ProjectsTableCreateCompanionBuilder =
    ProjectsCompanion Function({
      Value<int> localId,
      required int odooId,
      required String name,
      Value<double?> dateDJ,
      Value<double?> dateDN,
      Value<bool> active,
      Value<String?> updatedAt,
    });
typedef $$ProjectsTableUpdateCompanionBuilder =
    ProjectsCompanion Function({
      Value<int> localId,
      Value<int> odooId,
      Value<String> name,
      Value<double?> dateDJ,
      Value<double?> dateDN,
      Value<bool> active,
      Value<String?> updatedAt,
    });

class $$ProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odooId => $composableBuilder(
    column: $table.odooId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dateDJ => $composableBuilder(
    column: $table.dateDJ,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dateDN => $composableBuilder(
    column: $table.dateDN,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odooId => $composableBuilder(
    column: $table.odooId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dateDJ => $composableBuilder(
    column: $table.dateDJ,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dateDN => $composableBuilder(
    column: $table.dateDN,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<int> get odooId =>
      $composableBuilder(column: $table.odooId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get dateDJ =>
      $composableBuilder(column: $table.dateDJ, builder: (column) => column);

  GeneratedColumn<double> get dateDN =>
      $composableBuilder(column: $table.dateDN, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProjectsTable,
          Project,
          $$ProjectsTableFilterComposer,
          $$ProjectsTableOrderingComposer,
          $$ProjectsTableAnnotationComposer,
          $$ProjectsTableCreateCompanionBuilder,
          $$ProjectsTableUpdateCompanionBuilder,
          (Project, BaseReferences<_$AppDatabase, $ProjectsTable, Project>),
          Project,
          PrefetchHooks Function()
        > {
  $$ProjectsTableTableManager(_$AppDatabase db, $ProjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int> odooId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double?> dateDJ = const Value.absent(),
                Value<double?> dateDN = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
              }) => ProjectsCompanion(
                localId: localId,
                odooId: odooId,
                name: name,
                dateDJ: dateDJ,
                dateDN: dateDN,
                active: active,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                required int odooId,
                required String name,
                Value<double?> dateDJ = const Value.absent(),
                Value<double?> dateDN = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
              }) => ProjectsCompanion.insert(
                localId: localId,
                odooId: odooId,
                name: name,
                dateDJ: dateDJ,
                dateDN: dateDN,
                active: active,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProjectsTable,
      Project,
      $$ProjectsTableFilterComposer,
      $$ProjectsTableOrderingComposer,
      $$ProjectsTableAnnotationComposer,
      $$ProjectsTableCreateCompanionBuilder,
      $$ProjectsTableUpdateCompanionBuilder,
      (Project, BaseReferences<_$AppDatabase, $ProjectsTable, Project>),
      Project,
      PrefetchHooks Function()
    >;
typedef $$EmployeesTableCreateCompanionBuilder =
    EmployeesCompanion Function({
      Value<int> localId,
      required int odooId,
      required String name,
      Value<String?> jobName,
      Value<bool> active,
      Value<String?> updatedAt,
    });
typedef $$EmployeesTableUpdateCompanionBuilder =
    EmployeesCompanion Function({
      Value<int> localId,
      Value<int> odooId,
      Value<String> name,
      Value<String?> jobName,
      Value<bool> active,
      Value<String?> updatedAt,
    });

class $$EmployeesTableFilterComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odooId => $composableBuilder(
    column: $table.odooId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jobName => $composableBuilder(
    column: $table.jobName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EmployeesTableOrderingComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odooId => $composableBuilder(
    column: $table.odooId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jobName => $composableBuilder(
    column: $table.jobName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmployeesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<int> get odooId =>
      $composableBuilder(column: $table.odooId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get jobName =>
      $composableBuilder(column: $table.jobName, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EmployeesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmployeesTable,
          Employee,
          $$EmployeesTableFilterComposer,
          $$EmployeesTableOrderingComposer,
          $$EmployeesTableAnnotationComposer,
          $$EmployeesTableCreateCompanionBuilder,
          $$EmployeesTableUpdateCompanionBuilder,
          (Employee, BaseReferences<_$AppDatabase, $EmployeesTable, Employee>),
          Employee,
          PrefetchHooks Function()
        > {
  $$EmployeesTableTableManager(_$AppDatabase db, $EmployeesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmployeesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmployeesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmployeesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int> odooId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> jobName = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
              }) => EmployeesCompanion(
                localId: localId,
                odooId: odooId,
                name: name,
                jobName: jobName,
                active: active,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                required int odooId,
                required String name,
                Value<String?> jobName = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
              }) => EmployeesCompanion.insert(
                localId: localId,
                odooId: odooId,
                name: name,
                jobName: jobName,
                active: active,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EmployeesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmployeesTable,
      Employee,
      $$EmployeesTableFilterComposer,
      $$EmployeesTableOrderingComposer,
      $$EmployeesTableAnnotationComposer,
      $$EmployeesTableCreateCompanionBuilder,
      $$EmployeesTableUpdateCompanionBuilder,
      (Employee, BaseReferences<_$AppDatabase, $EmployeesTable, Employee>),
      Employee,
      PrefetchHooks Function()
    >;
typedef $$EquipmentsTableCreateCompanionBuilder =
    EquipmentsCompanion Function({
      Value<int> localId,
      required int odooId,
      required String name,
      Value<String?> categoryName,
      Value<int?> projectOdooId,
      Value<bool> active,
      Value<String?> updatedAt,
    });
typedef $$EquipmentsTableUpdateCompanionBuilder =
    EquipmentsCompanion Function({
      Value<int> localId,
      Value<int> odooId,
      Value<String> name,
      Value<String?> categoryName,
      Value<int?> projectOdooId,
      Value<bool> active,
      Value<String?> updatedAt,
    });

class $$EquipmentsTableFilterComposer
    extends Composer<_$AppDatabase, $EquipmentsTable> {
  $$EquipmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odooId => $composableBuilder(
    column: $table.odooId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get projectOdooId => $composableBuilder(
    column: $table.projectOdooId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EquipmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $EquipmentsTable> {
  $$EquipmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odooId => $composableBuilder(
    column: $table.odooId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get projectOdooId => $composableBuilder(
    column: $table.projectOdooId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EquipmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EquipmentsTable> {
  $$EquipmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<int> get odooId =>
      $composableBuilder(column: $table.odooId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get projectOdooId => $composableBuilder(
    column: $table.projectOdooId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EquipmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EquipmentsTable,
          Equipment,
          $$EquipmentsTableFilterComposer,
          $$EquipmentsTableOrderingComposer,
          $$EquipmentsTableAnnotationComposer,
          $$EquipmentsTableCreateCompanionBuilder,
          $$EquipmentsTableUpdateCompanionBuilder,
          (
            Equipment,
            BaseReferences<_$AppDatabase, $EquipmentsTable, Equipment>,
          ),
          Equipment,
          PrefetchHooks Function()
        > {
  $$EquipmentsTableTableManager(_$AppDatabase db, $EquipmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EquipmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EquipmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EquipmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int> odooId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> categoryName = const Value.absent(),
                Value<int?> projectOdooId = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
              }) => EquipmentsCompanion(
                localId: localId,
                odooId: odooId,
                name: name,
                categoryName: categoryName,
                projectOdooId: projectOdooId,
                active: active,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                required int odooId,
                required String name,
                Value<String?> categoryName = const Value.absent(),
                Value<int?> projectOdooId = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
              }) => EquipmentsCompanion.insert(
                localId: localId,
                odooId: odooId,
                name: name,
                categoryName: categoryName,
                projectOdooId: projectOdooId,
                active: active,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EquipmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EquipmentsTable,
      Equipment,
      $$EquipmentsTableFilterComposer,
      $$EquipmentsTableOrderingComposer,
      $$EquipmentsTableAnnotationComposer,
      $$EquipmentsTableCreateCompanionBuilder,
      $$EquipmentsTableUpdateCompanionBuilder,
      (Equipment, BaseReferences<_$AppDatabase, $EquipmentsTable, Equipment>),
      Equipment,
      PrefetchHooks Function()
    >;
typedef $$TasksTableCreateCompanionBuilder =
    TasksCompanion Function({
      Value<int> localId,
      required int odooId,
      Value<String?> numItem,
      required String libelle,
      Value<String?> typeTache,
      Value<String?> categorieActivity,
      Value<String?> categorie,
      Value<String?> typeActivite,
      Value<String?> updatedAt,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    TasksCompanion Function({
      Value<int> localId,
      Value<int> odooId,
      Value<String?> numItem,
      Value<String> libelle,
      Value<String?> typeTache,
      Value<String?> categorieActivity,
      Value<String?> categorie,
      Value<String?> typeActivite,
      Value<String?> updatedAt,
    });

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odooId => $composableBuilder(
    column: $table.odooId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get numItem => $composableBuilder(
    column: $table.numItem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libelle => $composableBuilder(
    column: $table.libelle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get typeTache => $composableBuilder(
    column: $table.typeTache,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categorieActivity => $composableBuilder(
    column: $table.categorieActivity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categorie => $composableBuilder(
    column: $table.categorie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get typeActivite => $composableBuilder(
    column: $table.typeActivite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odooId => $composableBuilder(
    column: $table.odooId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get numItem => $composableBuilder(
    column: $table.numItem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libelle => $composableBuilder(
    column: $table.libelle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get typeTache => $composableBuilder(
    column: $table.typeTache,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categorieActivity => $composableBuilder(
    column: $table.categorieActivity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categorie => $composableBuilder(
    column: $table.categorie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get typeActivite => $composableBuilder(
    column: $table.typeActivite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<int> get odooId =>
      $composableBuilder(column: $table.odooId, builder: (column) => column);

  GeneratedColumn<String> get numItem =>
      $composableBuilder(column: $table.numItem, builder: (column) => column);

  GeneratedColumn<String> get libelle =>
      $composableBuilder(column: $table.libelle, builder: (column) => column);

  GeneratedColumn<String> get typeTache =>
      $composableBuilder(column: $table.typeTache, builder: (column) => column);

  GeneratedColumn<String> get categorieActivity => $composableBuilder(
    column: $table.categorieActivity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categorie =>
      $composableBuilder(column: $table.categorie, builder: (column) => column);

  GeneratedColumn<String> get typeActivite => $composableBuilder(
    column: $table.typeActivite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
          Task,
          PrefetchHooks Function()
        > {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int> odooId = const Value.absent(),
                Value<String?> numItem = const Value.absent(),
                Value<String> libelle = const Value.absent(),
                Value<String?> typeTache = const Value.absent(),
                Value<String?> categorieActivity = const Value.absent(),
                Value<String?> categorie = const Value.absent(),
                Value<String?> typeActivite = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
              }) => TasksCompanion(
                localId: localId,
                odooId: odooId,
                numItem: numItem,
                libelle: libelle,
                typeTache: typeTache,
                categorieActivity: categorieActivity,
                categorie: categorie,
                typeActivite: typeActivite,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                required int odooId,
                Value<String?> numItem = const Value.absent(),
                required String libelle,
                Value<String?> typeTache = const Value.absent(),
                Value<String?> categorieActivity = const Value.absent(),
                Value<String?> categorie = const Value.absent(),
                Value<String?> typeActivite = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
              }) => TasksCompanion.insert(
                localId: localId,
                odooId: odooId,
                numItem: numItem,
                libelle: libelle,
                typeTache: typeTache,
                categorieActivity: categorieActivity,
                categorie: categorie,
                typeActivite: typeActivite,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
      Task,
      PrefetchHooks Function()
    >;
typedef $$LocationsTableCreateCompanionBuilder =
    LocationsCompanion Function({
      Value<int> localId,
      required int odooId,
      required String name,
      Value<String?> updatedAt,
    });
typedef $$LocationsTableUpdateCompanionBuilder =
    LocationsCompanion Function({
      Value<int> localId,
      Value<int> odooId,
      Value<String> name,
      Value<String?> updatedAt,
    });

class $$LocationsTableFilterComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odooId => $composableBuilder(
    column: $table.odooId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odooId => $composableBuilder(
    column: $table.odooId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<int> get odooId =>
      $composableBuilder(column: $table.odooId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocationsTable,
          Location,
          $$LocationsTableFilterComposer,
          $$LocationsTableOrderingComposer,
          $$LocationsTableAnnotationComposer,
          $$LocationsTableCreateCompanionBuilder,
          $$LocationsTableUpdateCompanionBuilder,
          (Location, BaseReferences<_$AppDatabase, $LocationsTable, Location>),
          Location,
          PrefetchHooks Function()
        > {
  $$LocationsTableTableManager(_$AppDatabase db, $LocationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<int> odooId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
              }) => LocationsCompanion(
                localId: localId,
                odooId: odooId,
                name: name,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                required int odooId,
                required String name,
                Value<String?> updatedAt = const Value.absent(),
              }) => LocationsCompanion.insert(
                localId: localId,
                odooId: odooId,
                name: name,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocationsTable,
      Location,
      $$LocationsTableFilterComposer,
      $$LocationsTableOrderingComposer,
      $$LocationsTableAnnotationComposer,
      $$LocationsTableCreateCompanionBuilder,
      $$LocationsTableUpdateCompanionBuilder,
      (Location, BaseReferences<_$AppDatabase, $LocationsTable, Location>),
      Location,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$EmployeesTableTableManager get employees =>
      $$EmployeesTableTableManager(_db, _db.employees);
  $$EquipmentsTableTableManager get equipments =>
      $$EquipmentsTableTableManager(_db, _db.equipments);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$LocationsTableTableManager get locations =>
      $$LocationsTableTableManager(_db, _db.locations);
}
