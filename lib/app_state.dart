import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/station.dart';

class InitialState {
  final List<Station> trackedStations;

  InitialState(this.trackedStations);

  static Future<InitialState> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var trackedStations = json.decode(prefs.getString('trackedStations'));
    trackedStations =
        (trackedStations as List).map((s) => Station.fromJson(s)).toList();
    return InitialState(trackedStations);
  }
}

class AppState extends ChangeNotifier {
  final List<Station> _trackedStations;

  AppState(this._trackedStations);

  UnmodifiableListView<Station> get trackedStations =>
      UnmodifiableListView(_trackedStations);

  Future<void> add(Station item) async {
    if (_trackedStations.any((e) => e.id == item.id)) {
      return;
    }

    _trackedStations.add(item);
    await _persist();
    notifyListeners();
  }

  Future<void> remove(Station item) async {
    _trackedStations.removeWhere((element) => element.id == item.id);
    await _persist();
    notifyListeners();
  }

  Future<void> _persist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('trackedStations', json.encode(trackedStations));
  }
}
