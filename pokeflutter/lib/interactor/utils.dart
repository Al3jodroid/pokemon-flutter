const int pokemonIdLength = 3;
const String pokemonIdPaddingChar = '0';

String pokemonNumberToUrlId(int pokemonNumber) {
  return pokemonNumber.toString().padLeft(
        pokemonIdLength,
        pokemonIdPaddingChar,
      );
}
