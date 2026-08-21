import 'package:pokeflutter/model/data/pokemon_info.dart';

sealed class PokemonUiState {}

class PokemonUiLoading extends PokemonUiState {}

class PokemonUiSuccess extends PokemonUiState {
  final PokemonInfo pokemon;
  PokemonUiSuccess(this.pokemon);
}

class PokemonUiError extends PokemonUiState {
  final String message;
  PokemonUiError(this.message);
}
