import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zvv_next/app_state.dart';
import 'package:zvv_next/services/http_service.dart';
import 'package:zvv_next/services/zvv_service.dart';

import 'widgets/app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState()),
        Provider(create: (context) => HttpService()),
        Provider(
          create: (context) => ZvvService(
            httpService: context.read<HttpService>(),
          ),
        ),
      ],
      child: App(),
    ),
  );
}
