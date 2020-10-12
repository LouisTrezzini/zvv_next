import 'dart:convert';

import 'package:zvv_next/models/connection.dart';
import 'package:zvv_next/models/station.dart';
import 'package:zvv_next/services/http_service.dart';

class ZvvService {
  final HttpService httpService;

  ZvvService({this.httpService});

  Future<List<Station>> searchStation(String query) async {
    var response = await httpService
        .get("https://online.fahrplan.zvv.ch/bin/ajax-getstop.exe/en", query: {
      "encoding": "utf-8",
      "start": "1",
      "getstop": "1",
      "suggestMethod": "none",
      "S": query,
      "REQ0JourneyStopsS0A": "1",
      "REQ0JourneyStopsB": "10",
      "REQ0JourneyStopsF": "distinguishStationAttribute%3BZH",
    });
    var result = jsonDecode(response.body.substring(8, response.body.length - 1));
    return (result["suggestions"] as List)
        .map((s) => Station.fromJson(s))
        .toList();
  }

  Future<List<Connection>> getStationTimetable(Station stationInfo) async {
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
    return (result["connections"] as List)
        .map((c) => Connection.fromJson(c))
        .toList();
  }
}

_now() {
  return DateTime.now().millisecondsSinceEpoch;
}
