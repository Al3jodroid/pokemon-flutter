import 'package:flutter/material.dart';
import 'package:pokeflutter/constants.dart';
import 'package:pokeflutter/interactor/pokemon_usecase.dart';

class PokemonViewModel extends ChangeNotifier {
  //Attributes to manage our business
  String _urlState = "";
  String get urlState => _urlState;

  //internal count used inside the viewmodel to manage
  //the pokemon number sequence
  int _countPokemon = startCountValue;

  //Pokemon UseCase instance (private)
  final PokemonUseCase pokemonUseCase;

  //Custom parametrizable constructor with dependency injection
  PokemonViewModel(this.pokemonUseCase);

  void getRandomPokemonImage() {
    _urlState = pokemonUseCase.generateRandomUrlImage();
    notifyListeners();
  }

  void getPokemonImage() {
    _urlState = pokemonUseCase.generateUrlImage(_countPokemon);
    notifyListeners();
    _countPokemon = _countPokemon++;
  }
}
