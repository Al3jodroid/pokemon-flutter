import 'package:pokeflutter/interactor/pokemon_usecase.dart';
import 'package:pokeflutter/interactor/utils.dart';

class PokemonInteractor implements PokemonUseCase {
  // Constant Definitions at class level (equivalence to the companion object)
  static const String urlBase =
      "https://www.pokemon.com/static-assets/content-assets/cms2/img/pokedex/detail/";
  static const String pngExtension = ".png";

  @override
  String generateRandomUrlImage() {
    //generate URL image random
    return "the_image_url_random";
  }

  @override
  String generateUrlImage(int pokemonNumber) {
    return urlBase + pokemonNumberToUrlId(pokemonNumber) + pngExtension;
  }
}
