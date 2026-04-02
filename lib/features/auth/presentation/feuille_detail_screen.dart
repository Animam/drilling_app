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

class _FeuilleDetailScreenState extends ConsumerState<FeuilleDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  Feuille? _feuille;
  int _lignesCount = 0;
  int _fuelCount = 0;
  int _employesCount = 0;

  double _totalFuel = 0.0;
  double _totalRr = 0.0;
  int _totalMeters = 0;

  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    Future.microtask(_load);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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

  Widget _buildTopData(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
              height: 30,
              color: Colors.black.withOpacity(0.05),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                value,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    final feuille = _feuille;
    if (feuille == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                _buildTopData("Projet", feuille.nomProjetOdooId.toString()),
                _buildTopData("Quart", feuille.quart),
                _buildTopData("Date", feuille.dateForage),
                _buildTopData("Foreuse", feuille.foreuseOdooId?.toString() ?? "-"),
                _buildTopData("Location", feuille.locationOdooId?.toString() ?? "-"),
                _buildTopData("Fuel meter", feuille.fuelMeter ?? "-"),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                _buildTopData("Hour meter", feuille.hourMeter?.toString() ?? "-"),
                _buildTopData("Total Drill", _totalMeters.toString()),
                _buildTopData("Drill Hours", _totalRr.toStringAsFixed(2)),
                _buildTopData("Fuel supplied", _totalFuel.toStringAsFixed(2)),
                _buildTopData("Employes", _employesCount.toString()),
                _buildTopData("Statut", feuille.syncStatus),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white.withOpacity(0.8),
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

  Widget _buildSectionLauncher({
    required String title,
    required String subtitle,
    required VoidCallback onPressed,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(subtitle, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text('Ouvrir'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildSectionLauncher(
          title: 'Lignes de temps',
          subtitle: '$_lignesCount ligne(s) enregistree(s)',
          onPressed: () async {
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
        _buildSectionLauncher(
          title: 'Employes',
          subtitle: '$_employesCount employe(s) enregistre(s)',
          onPressed: () async {
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
        const Center(
          child: Text('Materiels - a brancher ensuite'),
        ),
        _buildSectionLauncher(
          title: 'Equip. Aux / Fuel',
          subtitle: '$_fuelCount ligne(s) fuel - ${_totalFuel.toStringAsFixed(2)} L',
          onPressed: () async {
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
        const Center(
          child: Text('Security - a brancher ensuite'),
        ),
        const Center(
          child: Text('Frais - a brancher ensuite'),
        ),
      ],
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
          title: const Text(
            'Drilling Report Pro',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
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
                : Column(
                    children: [
                      _buildHeaderSection(),
                      _buildTabBar(),
                      Expanded(child: _buildTabContent()),
                    ],
                  ),
      ),
    );
  }
}
