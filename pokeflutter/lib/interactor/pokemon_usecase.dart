import 'package:pokeflutter/model/data/pokemon_info.dart';

abstract class PokemonUseCase {
  /// Formats the sequential ID to generate a valid network image URL
  String generateUrlImage(int pokemonNumber);

  /// Orchestrates the sequential Pokémon retrieval by ID
  Future<PokemonInfo?> getPokemonById(int pokemonId);

  /// Orchestrates the random Pokémon retrieval
  Future<PokemonInfo?> getPokemonRandom();
}
