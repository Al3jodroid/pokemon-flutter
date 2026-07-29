class PokemonInfo {
  final int id;
  final String name;
  final List<String> species;
  final List<String> movements;
  final String urlImage;

  PokemonInfo({
    required this.id,
    required this.name,
    required this.species,
    required this.movements,
    required this.urlImage,
  });

  // We override toString to easily print our object in the UI later
  @override
  String toString() {
    return 'PokemonInfo(id: $id, name: $name, species: $species, movements: ${movements.take(3)}..., urlImage: $urlImage)';
  }
}
