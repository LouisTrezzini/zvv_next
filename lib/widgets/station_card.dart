import 'package:flutter/material.dart';
import 'package:zvv_next/models/connection.dart';
import 'package:zvv_next/models/station.dart';

class StationCard extends StatelessWidget {
  final Station station;
  final List<Connection> connections;
  final Function onRemove;

  StationCard(this.station, {this.connections = const [], this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(station.id),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.tram),
            title: Text(station.name),
            trailing: onRemove != null
                ? IconButton(
                    icon: Icon(Icons.delete), onPressed: onRemove)
                : null,
          ),
          ...connections.map((c) {
            return ListTile(
              dense: true,
              leading: CircleAvatar(
                child: Text(c.line),
                radius: 14,
                backgroundColor: _colorFromHex(c.lineBackgroundColor),
                foregroundColor: _colorFromHex(c.lineForegroundColor),
              ),
              title: Text(
                "${c.directionType} ${c.direction} at ${c.time} (${c.expectedArrival.fromNow()})",
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}
