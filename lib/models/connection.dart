import 'package:html_unescape/html_unescape_small.dart';
import 'package:jiffy/jiffy.dart';

var unescape = new HtmlUnescape();

class Connection {
  final String line;
  final String lineBackgroundColor;
  final String lineForegroundColor;
  final String direction;
  final String directionType;
  final String date;
  final String time;

  Connection.fromJson(Map<String, dynamic> json)
      : line = json['product']['line'],
        lineBackgroundColor = json["product"]["color"]["bg"],
        lineForegroundColor = json["product"]["color"]["fg"],
        direction = unescape.convert(json["product"]["direction"]),
        directionType = json["product"]["directionType"],
        date = json["mainLocation"]["date"],
        time = json["mainLocation"]["time"];

  Jiffy get expectedArrival {
    return Jiffy("${this.date} ${this.time}", "d.M.yy H:m")..add(years: 2000);
  }
}
