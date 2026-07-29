import 'package:pokeflutter/model/data/pokemon_info.dart';

abstract class PokemonRepository {
  // The contract: Returns our pure Domain Model, or null if the Pokemon escapes
  Future<PokemonInfo?> getPokemonInfo(int id);
}
