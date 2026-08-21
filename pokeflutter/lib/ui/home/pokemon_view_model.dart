import 'package:flutter/foundation.dart';
import 'package:pokeflutter/interactor/pokemon_usecase.dart';
import 'package:pokeflutter/ui/state/pokemon_ui_state.dart';

class PokemonViewModel extends ChangeNotifier {
  final PokemonUseCase pokemonUseCase;

  PokemonViewModel(this.pokemonUseCase) {
    // Automatically trigger the first fetch on startup, matching Android's init block!
    getPokemonSequential();
  }

  // Initialize in loading state by default
  PokemonUiState _pokemonState = PokemonUiLoading();
  PokemonUiState get pokemonState => _pokemonState;
  // Control state for search mode: sequential or random
  bool _isRandomMode = false;
  bool get isRandomMode => _isRandomMode;
  // Internal counter for sequential navigation
  int _countPokemon = 1;

  /// Fetches a Pokémon by its sequential ID asynchronously
  Future<void> getPokemonSequential() async {
    _emitState(PokemonUiLoading()); // Emit loading state immediately

    try {
      final pokemon = await pokemonUseCase.getPokemonById(_countPokemon);

      if (pokemon != null) {
        _pokemonState = PokemonUiSuccess(pokemon);
        _countPokemon++; // Advance sequence only after success
      } else {
        _pokemonState = PokemonUiError("No data found for this Pokémon.");
      }
    } catch (e) {
      _pokemonState = PokemonUiError("Connection error occurred: $e");
    }
    notifyListeners();
  }

  /// Fetches a completely random Pokémon asynchronously
  Future<void> getPokemonRandom() async {
    _emitState(PokemonUiLoading()); // Emit loading state immediately

    try {
      // getPokemonRandom will be defined in our UseCase in the next section
      final pokemon = await pokemonUseCase.getPokemonRandom();

      if (pokemon != null) {
        _pokemonState = PokemonUiSuccess(pokemon);
      } else {
        _pokemonState = PokemonUiError("No data found for this Pokémon.");
      }
    } catch (e) {
      _pokemonState = PokemonUiError("Connection error occurred: $e");
    }

    notifyListeners();
  }

  /// Helper method to mutate the state and notify the UI
  void _emitState(PokemonUiState newState) {
    _pokemonState = newState;
    notifyListeners();
  }

  /// Toggles the search mode and notifies observers
  void toggleRandomMode() {
    _isRandomMode = !_isRandomMode;
    notifyListeners();
  }
}
