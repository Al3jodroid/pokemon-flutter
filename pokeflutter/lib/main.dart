import 'package:flutter/material.dart';
import 'package:pokeflutter/ui/home/pokemon_view_model.dart';
import 'package:pokeflutter/interactor/pokemon_interactor.dart';
import 'package:pokeflutter/interactor/pokemon_usecase.dart';
import 'package:pokeflutter/ui/my_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<PokemonUseCase>(
          create: (_) => PokemonInteractor(),
        ),
        ChangeNotifierProvider(
          create: (context) => PokemonViewModel(
              Provider.of<PokemonUseCase>(context, listen: false)),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
