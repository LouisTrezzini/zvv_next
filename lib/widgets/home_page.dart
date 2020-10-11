import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zvv_next/models/station_info.dart';

import 'station_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<StationInfo> _stations = [];

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
            return StationCard(_stations[index]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStation,
        tooltip: 'Add tracked station',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addStation() {
    log("clicked");
    setState(() {
      _stations.add(StationInfo((_stations.length + 1).toString(), "Salersteig ${_stations.length + 1}"));
    });
  }
}
