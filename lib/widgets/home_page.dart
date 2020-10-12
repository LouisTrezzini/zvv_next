import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zvv_next/models/connection.dart';
import 'package:zvv_next/models/station.dart';
import 'package:zvv_next/services/zvv_service.dart';

import '../app_state.dart';
import '../constants.dart';
import 'station_card.dart';

class HydratedStation {
  final Station station;
  final List<Connection> connections;

  HydratedStation(this.station, this.connections);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isEditMode = false;
  List<HydratedStation> _hydratedStations = [];

  @override
  void initState() {
    super.initState();
    context.read<AppState>().addListener(_rehydrateStations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ZVV Next'),
        actions: [
          IconButton(
            icon: Icon(_isEditMode ? Icons.edit_off : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditMode = !_isEditMode;
              });
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _rehydrateStations,
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: _hydratedStations.length,
          itemBuilder: (context, index) {
            var pair = _hydratedStations[index];
            return StationCard(
              pair.station,
              connections: pair.connections,
              onRemove: _isEditMode ? () => _removeStation(pair.station) : null,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStation,
        tooltip: 'Add tracked station',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _addStation() async {
    Navigator.of(context).pushNamed(ADD_TRACKED_STATION_ROUTE);
  }

  void _removeStation(Station station) {
    context.read<AppState>().remove(station);
  }

  Future<void> _rehydrateStations() async {
    log("Refreshing connections");
    ZvvService zvvService = context.read<ZvvService>();
    List<HydratedStation> hydratedStations = await Future.wait(
        context.read<AppState>().trackedStations.map((station) async {
      var connections = await zvvService.getStationTimetable(station);
      return HydratedStation(station, connections);
    }));
    setState(() {
      _hydratedStations = hydratedStations;
    });
  }
}
