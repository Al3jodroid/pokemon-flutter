import 'package:pokeflutter/interactor/pokemon_usecase.dart';

class PokemonInteractor implements PokemonUseCase {
  @override
  String generateRandomUrlImage() {
    return "the_image_url_random";
  }

  @override
  String generateUrlImage(int pokemonNumber) {
    return "the_image_url_sequence";
  }
}
