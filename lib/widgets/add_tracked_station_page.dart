import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:zvv_next/app_state.dart';
import 'package:zvv_next/models/connection.dart';
import 'package:zvv_next/models/station.dart';
import 'package:zvv_next/services/zvv_service.dart';
import 'package:zvv_next/widgets/station_card.dart';

class AddTrackedStationPage extends StatefulWidget {
  @override
  _AddTrackedStationPageState createState() => _AddTrackedStationPageState();
}

class _AddTrackedStationPageState extends State<AddTrackedStationPage> {
  Station _selectedStation;
  List<Connection> _connections;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add tracked station'),
      ),
      body: Form(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                suggestionsCallback: (pattern) async {
                  if (pattern == null || pattern.isEmpty) {
                    return null;
                  }

                  return await context
                      .read<ZvvService>()
                      .searchStation(pattern);
                },
                itemBuilder: (context, Station suggestion) {
                  return ListTile(
                    leading: Icon(Icons.tram),
                    title: Text(suggestion.name),
                  );
                },
                onSuggestionSelected: (Station suggestion) async {
                  var connections = await context
                      .read<ZvvService>()
                      .getStationTimetable(suggestion);
                  setState(() {
                    _selectedStation = suggestion;
                    _connections = connections;
                  });
                },
              ),
              SizedBox(height: 8),
              _selectedStation != null
                  ? StationCard(_selectedStation, connections: _connections)
                  : Text("Please choose a station"),
              SizedBox(height: 8),
              ElevatedButton(
                child: Text("Add to my tracked stations"),
                onPressed: _selectedStation != null ? _submit : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    await context.read<AppState>().add(_selectedStation);
    Navigator.of(context).pop();
  }
}
