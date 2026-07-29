import 'package:pokeflutter/model/data/pokemon_info.dart';
import 'package:pokeflutter/model/dto/pokemon_dto.dart';

extension PokemonMapper on PokemonDto {
  // Extension function to map the DTO safely to our pure Domain Model
  PokemonInfo toDomainModel(String imageUrl) {
    return PokemonInfo(
      id: id ?? 0,
      name: name ?? "",

      // We safely navigate the nested dynamic list to extract the species/types names
      species: (types)?.map((t) => t['type']['name'] as String).toList() ?? [],

      // We extract only the name of each movement, discarding the rest of the JSON noise
      movements:
          (moves)?.map((m) => m['move']['name'] as String).toList() ?? [],

      // We inject the previously generated URL
      urlImage: imageUrl,
    );
  }
}
