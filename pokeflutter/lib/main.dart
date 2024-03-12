import 'package:flutter/material.dart';
import 'package:pokeflutter/constants.dart';
import 'package:pokeflutter/counter_provider.dart';
import 'package:pokeflutter/my_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterProvider(startCountValue),
      child: const MyApp(),
    ),
  );
}
