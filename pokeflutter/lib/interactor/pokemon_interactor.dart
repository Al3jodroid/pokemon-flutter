import 'dart:math';

import 'package:pokeflutter/interactor/pokemon_usecase.dart';
import 'package:pokeflutter/interactor/utils.dart';
import 'package:pokeflutter/model/data/pokemon_info.dart';
import 'package:pokeflutter/repository/pokemon_repository.dart';

class PokemonInteractor implements PokemonUseCase {
  // We inject the Repository (Dependency Inversion!)
  final PokemonRepository repository;

  // Constant Definitions at class level
  static const String urlBase =
      "https://www.pokemon.com/static-assets/content-assets/cms2/img/pokedex/detail/";
  static const String pngExtension = ".png";

  // Limits for the first generation of Pokémon
  static const int gen1MinId = 1;
  static const int gen1MaxId = 151;

  PokemonInteractor(this.repository);

// The Specialist orchestrates the data sequentially using the corrected name
  @override
  Future<PokemonInfo?> getPokemonById(int pokemonId) async {
    // We ask the Repository for the pure, incomplete data
    final pokemon = await repository.getPokemonInfo(pokemonId);

    if (pokemon != null) {
      // We calculate the specific URL using our existing logic
      final imageUrl = generateUrlImage(pokemonId);

      // We merge both worlds manually, returning the complete Domain Model
      return PokemonInfo(
        id: pokemon.id,
        name: pokemon.name,
        species: pokemon.species,
        movements: pokemon.movements,
        urlImage: imageUrl, // The injected URL!
      );
    }
    return null;
  }

  // New orchestrator to handle the random generation rule safely
  @override
  Future<PokemonInfo?> getPokemonRandom() async {
    // Calculate a random number between 1 and 151 safely inside the domain layer
    final randomId = Random().nextInt(gen1MaxId) + gen1MinId;

    // We reuse our sequential method to fetch and map the random Pokémon
    return getPokemonById(randomId);
  }

  @override
  String generateUrlImage(int pokemonNumber) {
    return urlBase + pokemonNumberToUrlId(pokemonNumber) + pngExtension;
  }
}
