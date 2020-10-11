import 'package:flutter/material.dart';
import 'package:zvv_next/models/connection.dart';
import 'package:zvv_next/models/station_info.dart';
import 'package:zvv_next/services/zvv_service.dart';

import 'station_card.dart';

var XXX = StationInfo(
    "A=1@O=Zürich, Salersteig@X=8548481@Y=47406071@U=85@L=008591332@B=1@p=1601975100@",
    "Zürich, Salersteig");

class HomePage extends StatefulWidget {
  final ZvvService zvvService;

  HomePage({this.zvvService});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<StationInfo> _stations = [];
  final Map<StationInfo, List<Connection>> _connections = {};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ZVV Next'),
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: _stations.length,
          itemBuilder: (context, index) {
            var station = _stations[index];
            return StationCard(station, connections: _connections[station]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStation,
        tooltip: 'Add tracked station',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addStation() async {
    // log("clicked");
    // setState(() {
    //   _stations.add(StationInfo((_stations.length + 1).toString(), "Salersteig ${_stations.length + 1}"));
    // });
    var x = await this.widget.zvvService.getStationTimetable(XXX);
    print(x);
    setState(() {
      _stations.clear();
      _stations.add(XXX);
      _connections[XXX] = x;
    });
  }
}
