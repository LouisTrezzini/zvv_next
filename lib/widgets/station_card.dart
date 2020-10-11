import 'package:flutter/material.dart';
import 'package:zvv_next/models/station_info.dart';

class StationCard extends StatelessWidget {
  final StationInfo station;

  StationCard(this.station);

  // Fields in a Widget subclass are always marked "final".

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(station.id),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.train),
            title: Text(station.name),
          ),
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
