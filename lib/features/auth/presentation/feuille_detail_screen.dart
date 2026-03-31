import 'package:drilling_app/data/local/db/app_database.dart';
import 'package:drilling_app/features/auth/presentation/fuel_list_screen.dart';
import 'package:drilling_app/features/auth/presentation/ligne_feuille_screen.dart';
import 'package:drilling_app/features/auth/presentation/list_employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/app_providers.dart';


class FeuilleDetailScreen extends ConsumerStatefulWidget {
  const FeuilleDetailScreen({
    super.key,
    required this.feuilleLocalId,
  });

  final int feuilleLocalId;

  @override
  ConsumerState<FeuilleDetailScreen> createState() => _FeuilleDetailScreenState();
}

class _FeuilleDetailScreenState extends ConsumerState<FeuilleDetailScreen> {
  Feuille? _feuille;
  int _lignesCount = 0;
  int _fuelCount = 0;
  int _employesCount = 0;

  double _totalFuel = 0.0;
  double _totalRr = 0.0;
  int _totalMeters = 0;

  String? _error;
  bool _loading = true;

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final db = ref.read(appDatabaseProvider);

      final feuille = await (db.select(db.feuilles)
            ..where((tbl) => tbl.localId.equals(widget.feuilleLocalId)))
          .getSingle();

      final lignes = await db.getLignesByFeuille(widget.feuilleLocalId);
      final fuels = await db.getFuelsByFeuille(widget.feuilleLocalId);
      final employes = await db.getEmployesByFeuille(widget.feuilleLocalId);

      final totalFuel = fuels.fold<double>(0.0, (sum, item) => sum + item.qytFuel);
      final totalRr = lignes.fold<double>(0.0, (sum, item) => sum + (item.rr ?? 0.0));
      final totalMeters = lignes.fold<int>(0, (sum, item) => sum + (item.totalDim ?? 0));

      setState(() {
        _feuille = feuille;
        _lignesCount = lignes.length;
        _fuelCount = fuels.length;
        _employesCount = employes.length;
        _totalFuel = totalFuel;
        _totalRr = totalRr;
        _totalMeters = totalMeters;
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

  Widget _buildInfoCard() {
    final feuille = _feuille;
    if (feuille == null) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoRow('Projet ID', feuille.nomProjetOdooId.toString()),
            _buildInfoRow('Quart', feuille.quart),
            _buildInfoRow('Date forage', feuille.dateForage),
            _buildInfoRow('Foreuse ID', feuille.foreuseOdooId?.toString() ?? '-'),
            _buildInfoRow('Location ID', feuille.locationOdooId?.toString() ?? '-'),
            _buildInfoRow('Hour meter', feuille.hourMeter?.toString() ?? '-'),
            _buildInfoRow('Fuel meter', feuille.fuelMeter ?? '-'),
            _buildInfoRow('Statut sync', feuille.syncStatus),
            _buildInfoRow('Remarques', feuille.remarks ?? '-'),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoRow('Fuel supplied', _totalFuel.toStringAsFixed(2)),
            _buildInfoRow('Compteur d\'horaires de forage', _totalRr.toStringAsFixed(2)),
            _buildInfoRow('Total meters drill', _totalMeters.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionButton({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(value),
          ),
        ],
      ),
    );
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
        title: const Text('Detail feuille'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      const Text(
                        'Informations generales',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _buildInfoCard(),
                      const SizedBox(height: 16),
                      const Text(
                        'Totaux calcules localement',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _buildTotalsCard(),
                      const SizedBox(height: 16),
                      const Text(
                        'Sections',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _buildSectionButton(
                        title: 'Lignes de temps',
                        subtitle: '$_lignesCount ligne(s)',
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => FeuilleLignesScreen(
                                feuilleLocalId: widget.feuilleLocalId,
                              ),
                            ),
                          );
                          _load();
                        },
                      ),
                      _buildSectionButton(
                        title: 'Fuel supplied',
                        subtitle: '$_fuelCount ligne(s) - ${_totalFuel.toStringAsFixed(2)} L',
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => FeuilleFuelsScreen(
                                feuilleLocalId: widget.feuilleLocalId,
                              ),
                            ),
                          );
                          _load();
                        },
                      ),
                      _buildSectionButton(
                        title: 'Employes',
                        subtitle: '$_employesCount employe(s)',
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => FeuilleEmployesScreen(
                                feuilleLocalId: widget.feuilleLocalId,
                              ),
                            ),
                          );
                          _load();
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Etape suivante: marquer la feuille prete pour sync'),
                              ),
                            );
                          },
                          child: const Text('Marquer pret pour synchronisation'),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
