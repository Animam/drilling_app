import 'package:drilling_app/data/local/db/app_database.dart';
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
      
      appBar: AppBar(title: const Text('Liste Feuilles locales'),centerTitle: true,backgroundColor: Color(0xFFF18E28),),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const FeuilleFormScreen()));
          _load();
        },
        child: const Icon(Icons.add),
        backgroundColor: Color(0xFFF18E28),
      ),
      body: Container(
             width: double.infinity,
        decoration: const BoxDecoration(
          // Dégradé de fond
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFDF8E1), Color(0xFFF5F5F5)],
          ),
        ),
        child: _items.isEmpty
            ? const Center(child: Text('Aucune feuille locale'))
            : ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
        
                  return Container(
                         width: double.infinity,
        decoration: const BoxDecoration(
          // Dégradé de fond
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFDF8E1), Color(0xFFF5F5F5)],
          ),
        ),
                    child: Card(
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
                              builder: (_) =>
                                  FeuilleFormScreen(feuilleLocalId: item.localId),
                            ),
                          );
                          _load();
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
