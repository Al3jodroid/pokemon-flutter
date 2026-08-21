import 'package:flutter/material.dart';
import 'package:pokeflutter/model/data/pokemon_info.dart';

class PokemonCardWidget extends StatelessWidget {
  final PokemonInfo pokemon;

  const PokemonCardWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Helper to capitalize the first letter of a string (equivalent to replaceFirstChar)
    String capitalize(String text) {
      if (text.isEmpty) return text;
      return '${text[0].toUpperCase()}${text.substring(1)}';
    }

    return Card(
      elevation: 8.0,
      color: colorScheme
          .surfaceContainerHighest, // Matches containerColor = surfaceVariant
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16.0), // Matches RoundedCornerShape(16.dp)
      ),
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Pokémon Name and ID Header (Matches headlineMedium and onSurfaceVariant)
            Text(
              '#${pokemon.id} - ${capitalize(pokemon.name)}',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16.0),

            // 2. Coil AsyncImage mirror: circular background, surface color, and 8.dp padding
            Container(
              width: 180.0,
              height: 180.0,
              decoration: BoxDecoration(
                color: colorScheme.surface, // Matches CircleShape background
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8.0), // Matches padding(8.dp)
              child: Image.network(
                pokemon.urlImage,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16.0),

            // 3. Species / Types rendered as clean chips (Matches SuggestionChip)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pokemon.species.map((type) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Chip(
                    label: Text(capitalize(type)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          50.0), // Matches RoundedCornerShape(50.dp)
                    ),
                    side: BorderSide.none,
                    backgroundColor: colorScheme.surface,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),

            // 4. Movements Section Header
            const Text(
              'Key Movements', // Matches R.string.key_movements
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),

            // 5. Displaying up to 3 main movements as custom badges
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pokemon.movements.take(3).map((move) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: colorScheme.primary
                        .withOpacity(0.1), // Matches primary.copy(alpha = 0.1f)
                    borderRadius: BorderRadius.circular(
                        8.0), // Matches RoundedCornerShape(8.dp)
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6.0),
                  child: Text(
                    move,
                    style: TextStyle(
                      fontSize: 12.0, // Matches typography.bodySmall
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
