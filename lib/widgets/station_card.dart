import 'package:flutter/material.dart';
import 'package:zvv_next/models/connection.dart';
import 'package:zvv_next/models/station_info.dart';

class StationCard extends StatelessWidget {
  final StationInfo station;
  final List<Connection> connections;

  StationCard(this.station, {this.connections});

  // Fields in a Widget subclass are always marked "final".

  @override
  Widget build(BuildContext context) {
    print(connections[0].expectedArrival);
    return Card(
      key: Key(station.id),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.tram),
            title: Text(station.name),
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
                  "${c.directionType} ${c.direction} at ${c.time} (${c.expectedArrival.fromNow()})"),
            );
          }).toList(),
          // Row(
          //   children: [
          //     TextButton(
          //       child: const Text('BUY TICKETS'),
          //       onPressed: () {
          //         /* ... */
          //       },
          //     ),
          //     const SizedBox(width: 8),
          //     TextButton(
          //       child: const Text('LISTEN'),
          //       onPressed: () {
          //         /* ... */
          //       },
          //     ),
          //     const SizedBox(width: 8),
          //   ],
          // ),
        ],
      ),
    );
  }
}

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}
