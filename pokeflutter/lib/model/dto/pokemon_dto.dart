class PokemonDto {
  final int? id;
  final String? name;
  final List<dynamic>? types;
  final List<dynamic>? moves;

  PokemonDto({this.id, this.name, this.types, this.moves});

  // In Dart, we use a factory constructor to parse the raw JSON Map.
  // We manually map the JSON keys to our class properties safely.
  factory PokemonDto.fromJson(Map<String, dynamic> json) {
    return PokemonDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
      types: json['types'] as List<dynamic>?,
      moves: json['moves'] as List<dynamic>?,
    );
  }
}
