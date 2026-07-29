import 'package:pokeflutter/model/data/pokemon_info.dart';

abstract class PokemonUseCase {
  // The new evolved method!
  Future<PokemonInfo?> getCompletePokemon(int pokemonNumber);

  String generateRandomUrlImage();
  String generateUrlImage(int pokemonNumber);
}
