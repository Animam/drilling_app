import 'package:drilling_app/data/local/db/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/app_providers.dart';
import 'fuel_form_screen.dart';

class FeuilleFuelsScreen extends ConsumerStatefulWidget {
  const FeuilleFuelsScreen({
    super.key,
    required this.feuilleLocalId,
  });

  final int feuilleLocalId;

  @override
  ConsumerState<FeuilleFuelsScreen> createState() => _FeuilleFuelsScreenState();
}

class _FeuilleFuelsScreenState extends ConsumerState<FeuilleFuelsScreen> {
  List<FeuilleFuel> _items = [];
  double _totalFuel = 0.0;

  Future<void> _load() async {
    final db = ref.read(appDatabaseProvider);
    final data = await db.getFuelsByFeuille(widget.feuilleLocalId);
    final total = await db.getTotalFuelByFeuille(widget.feuilleLocalId);

    setState(() {
      _items = data;
      _totalFuel = total;
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
        title: const Text('Fuel supplied'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => FuelFormScreen(
                feuilleLocalId: widget.feuilleLocalId,
              ),
            ),
          );
          _load();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: const Text('Total Fuel'),
              trailing: Text(
                _totalFuel.toStringAsFixed(2),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: _items.isEmpty
                ? const Center(child: Text('Aucune ligne fuel'))
                : ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return ListTile(
                        title: Text('Equipement ID: ${item.compresseurOdooId ?? '-'}'),
                        subtitle: Text(
                          'Debut: ${item.dateDEqui ?? '-'} | Fin: ${item.dateFEqui ?? '-'}',
                        ),
                        trailing: Text(item.qytFuel.toStringAsFixed(2)),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
