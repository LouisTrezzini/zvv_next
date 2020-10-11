import 'dart:convert';

import 'package:zvv_next/models/connection.dart';
import 'package:zvv_next/models/station_info.dart';
import 'package:zvv_next/services/http_service.dart';

class ZvvService {
  final HttpService httpService;

  ZvvService({this.httpService});

  Future<List<Connection>> getStationTimetable(StationInfo stationInfo) async {
    var response = await httpService.post(
      "https://online.fahrplan.zvv.ch/bin/stboard.exe/eny?_ts=${_now()}",
      {
        "maxJourneys": "4",
        "REQStationS0ID": stationInfo.id,
        "boardType": "dep",
        "start": "1",
        "tpl": "stbResult2json",
      },
    );
    var result = jsonDecode(response.body);
    return (result["connections"] as List).map((c) => Connection.fromJson(c)).toList();
  }
}

_now() {
  return DateTime.now().millisecondsSinceEpoch;
}
