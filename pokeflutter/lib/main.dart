import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokeflutter/repository/pokemon_repository.dart';
import 'package:pokeflutter/repository/pokemon_repository_impl.dart';
import 'package:pokeflutter/ui/home/pokemon_view_model.dart';
import 'package:pokeflutter/ui/my_app.dart';
import 'package:provider/provider.dart';

import 'package:pokeflutter/client/api/pokemon_api.dart';
import 'package:pokeflutter/client/api/pokemon_http_api.dart';
import 'package:pokeflutter/interactor/pokemon_usecase.dart';
import 'package:pokeflutter/interactor/pokemon_interactor.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // 1. Base HTTP Client
        Provider<http.Client>(
          create: (_) => http.Client(),
        ),

        // 2. Network Antenna (API) - Injects http.Client
        Provider<PokemonApi>(
          create: (context) => PokemonHttpApi(
            context.read<http.Client>(),
          ),
        ),

        // 3. Repository (Professor Oak) - Injects PokemonApi
        Provider<PokemonRepository>(
          create: (context) => PokemonRepositoryImpl(
            context.read<PokemonApi>(),
          ),
        ),

        // 4. Use Case (Specialist) - Injects PokemonRepository
        Provider<PokemonUseCase>(
          create: (context) => PokemonInteractor(
            context.read<PokemonRepository>(),
          ),
        ),

        // 5. ViewModel - Injects PokemonUseCase & emits state to UI
        ChangeNotifierProvider(
          create: (context) => PokemonViewModel(
            context.read<PokemonUseCase>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
