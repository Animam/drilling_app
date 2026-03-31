import 'package:drilling_app/data/local/db/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/app_providers.dart';
import 'ligne_form_screen.dart';

class FeuilleLignesScreen extends ConsumerStatefulWidget {
  const FeuilleLignesScreen({
    super.key,
    required this.feuilleLocalId,
  });

  final int feuilleLocalId;

  @override
  ConsumerState<FeuilleLignesScreen> createState() => _FeuilleLignesScreenState();
}

class _FeuilleLignesScreenState extends ConsumerState<FeuilleLignesScreen> {
  List<FeuilleLigne> _lignes = [];

  Future<void> _load() async {
    final db = ref.read(appDatabaseProvider);
    final data = await db.getLignesByFeuille(widget.feuilleLocalId);

    setState(() {
      _lignes = data;
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
        title: const Text('Lignes de temps'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => LigneFormScreen(
                feuilleLocalId: widget.feuilleLocalId,
              ),
            ),
          );
          _load();
        },
        child: const Icon(Icons.add),
      ),
      body: _lignes.isEmpty
          ? const Center(child: Text('Aucune ligne'))
          : ListView.builder(
              itemCount: _lignes.length,
              itemBuilder: (context, index) {
                final ligne = _lignes[index];
                return ListTile(
                  title: Text('Item: ${ligne.item}'),
                  subtitle: Text(
                    'Heure debut: ${ligne.dateD ?? '-'} | Heure fin: ${ligne.dateF ?? '-'}',
                  ),
                  trailing: Text('rr: ${ligne.rr ?? 0}'),
                );
              },
            ),
    );
  }
}
