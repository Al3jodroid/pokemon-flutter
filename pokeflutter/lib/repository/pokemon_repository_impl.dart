import 'package:pokeflutter/client/api/pokemon_api.dart';
import 'package:pokeflutter/model/data/pokemon_info.dart';
import 'package:pokeflutter/model/mapper/pokemon_mapper.dart';
import 'package:pokeflutter/repository/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonApi api;

  // We inject the API via constructor (Dependency Inversion in action!)
  PokemonRepositoryImpl(this.api);

  @override
  Future<PokemonInfo?> getPokemonInfo(int id) async {
    // We ask the antenna for the raw DTO
    final dto = await api.getPokemonById(id);

    if (dto != null) {
      // We use our extension to map the chaotic DTO to our pure model.
      // We pass an empty string because the URL is the UseCase's responsibility.
      return dto.toDomainModel("");
    }
    return null;
  }
}
