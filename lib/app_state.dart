import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'models/station.dart';

class AppState extends ChangeNotifier {
  final List<Station> _trackedStations = [];

  UnmodifiableListView<Station> get trackedStations => UnmodifiableListView(_trackedStations);

  void add(Station item) {
    if (_trackedStations.any((e) => e.id == item.id)) {
      return;
    }

    _trackedStations.add(item);
    notifyListeners();
  }

  void remove(Station item) {
    _trackedStations.removeWhere((element) => element.id == item.id);
    notifyListeners();
  }
}