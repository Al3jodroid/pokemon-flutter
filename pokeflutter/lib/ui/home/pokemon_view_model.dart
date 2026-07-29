import 'package:flutter/foundation.dart';
import 'package:pokeflutter/constants.dart';
import 'package:pokeflutter/interactor/pokemon_usecase.dart';
import 'package:pokeflutter/model/data/pokemon_info.dart';

class PokemonViewModel extends ChangeNotifier {
  // We evolve from a simple String URL to our pure Domain Model
  PokemonInfo? _pokemonState;
  PokemonInfo? get pokemonState => _pokemonState;

  // Internal count used inside the viewmodel to manage
  // the pokemon number sequence
  int _countPokemon = startCountValue;

  // Pokemon UseCase instance (private)
  final PokemonUseCase pokemonUseCase;

  // Custom parametrizable constructor with dependency injection
  PokemonViewModel(this.pokemonUseCase);

  // Asynchronous method triggered by the UI
  Future<void> getCompletePokemon() async {
    debugPrint("Fetching Pokemon ID: $_countPokemon...");
    // 1. We ask the UseCase asynchronously without freezing the UI thread
    final result = await pokemonUseCase.getCompletePokemon(_countPokemon);

    if (result != null) {
      _pokemonState = result;

      // 2. Golden Rule: Debug Console verification!
      debugPrint("Pokemon Data Retrieved: ${_pokemonState.toString()}");

      _countPokemon++;

      // 3. We notify all listening widgets to rebuild
      notifyListeners();
    } else {
      debugPrint("Failed to retrieve Pokemon data for ID: $_countPokemon (result was null)");
    }
  }

  // Legacy method for random image generation
  void getRandomPokemonImage() {
    // If required for random image logic
    notifyListeners();
  }
}
