import 'package:pokeflutter/model/dto/pokemon_dto.dart';

abstract class PokemonApi {
  // A Future represents an asynchronous operation in Dart.
  // It promises to return a PokemonDto (or null) at some point in time.
  Future<PokemonDto?> getPokemonById(int id);
}
