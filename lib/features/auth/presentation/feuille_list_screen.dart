/* import 'package:drilling_app/data/local/db/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/app_providers.dart';
import 'feuille_form_screen.dart';

class FeuilleListScreen extends ConsumerStatefulWidget {
  const FeuilleListScreen({super.key});

  @override
  ConsumerState<FeuilleListScreen> createState() => _FeuilleListScreenState();
}

class _FeuilleListScreenState extends ConsumerState<FeuilleListScreen> {
  List<Feuille> _items = [];

  Future<void> _load() async {
    final db = ref.read(appDatabaseProvider);
    final data = await db.getVisibleFeuilles();

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
        title: const Text('Feuilles locales'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const FeuilleFormScreen(),
            ),
          );
          _load();
        },
        child: const Icon(Icons.add),
      ),
      body: _items.isEmpty
          ? const Center(child: Text('Aucune feuille locale'))
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return ListTile(
                  title: Text('Projet ID: ${item.nomProjetOdooId}'),
                  subtitle: Text('${item.quart} - ${item.dateForage}'),
                  trailing: Text(item.syncStatus),
                );
              },
            ),
    );
  }
}
 */


import 'package:drilling_app/data/local/db/app_database.dart';
import 'package:drilling_app/features/auth/presentation/feuille_detail_screen.dart';
import 'package:drilling_app/features/auth/presentation/fuel_list_screen.dart';
import 'package:drilling_app/features/auth/presentation/ligne_feuille_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/app_providers.dart';
import 'feuille_form_screen.dart';

class FeuilleListScreen extends ConsumerStatefulWidget {
  const FeuilleListScreen({super.key});

  @override
  ConsumerState<FeuilleListScreen> createState() => _FeuilleListScreenState();
}

class _FeuilleListScreenState extends ConsumerState<FeuilleListScreen> {
  List<Feuille> _items = [];

  Future<void> _load() async {
    final db = ref.read(appDatabaseProvider);
    final data = await db.getVisibleFeuilles();

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
        title: const Text('Feuilles locales'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const FeuilleFormScreen(),
            ),
          );
          _load();
        },
        child: const Icon(Icons.add),
      ),
      body: _items.isEmpty
          ? const Center(child: Text('Aucune feuille locale'))
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];

                return Card(
                  child: ListTile(
                    title: Text('Projet ID: ${item.nomProjetOdooId}'),
                    subtitle: Text(
                      '${item.quart} - ${item.dateForage}\nSync: ${item.syncStatus}',
                    ),
                    isThreeLine: true,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => FeuilleDetailScreen(
                  feuilleLocalId: item.localId,
                ),
              ),
            );

              _load();
            },
                  ),
                );
              },
            ),
    );
  }
}
