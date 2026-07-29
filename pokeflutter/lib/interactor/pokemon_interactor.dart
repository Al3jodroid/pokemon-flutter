import 'package:pokeflutter/interactor/pokemon_usecase.dart';
import 'package:pokeflutter/interactor/utils.dart';
import 'package:pokeflutter/model/data/pokemon_info.dart';
import 'package:pokeflutter/repository/pokemon_repository.dart';

class PokemonInteractor implements PokemonUseCase {
  // 1. We inject the Repository (Dependency Inversion!)
  final PokemonRepository repository;

  // Constant Definitions at class level
  static const String urlBase =
      "https://www.pokemon.com/static-assets/content-assets/cms2/img/pokedex/detail/";
  static const String pngExtension = ".png";

  PokemonInteractor(this.repository);

  // 2. The Specialist orchestrates the data
  @override
  Future<PokemonInfo?> getCompletePokemon(int pokemonNumber) async {
    // We ask the Repository for the pure, incomplete data
    final pokemon = await repository.getPokemonInfo(pokemonNumber);

    if (pokemon != null) {
      // We calculate the specific URL using our existing logic
      final imageUrl = generateUrlImage(pokemonNumber);

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

  @override
  String generateRandomUrlImage() {
    // generate URL image random
    return "the_image_url_random";
  }

  @override
  String generateUrlImage(int pokemonNumber) {
    return urlBase + pokemonNumberToUrlId(pokemonNumber) + pngExtension;
  }
}
