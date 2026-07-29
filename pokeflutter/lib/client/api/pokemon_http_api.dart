import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pokeflutter/client/api/pokemon_api.dart';
import 'package:pokeflutter/model/dto/pokemon_dto.dart';

class PokemonHttpApi implements PokemonApi {
  // The client that executes the HTTP requests (equivalent to Retrofit instance)
  final http.Client client;
  final String baseUrl = "https://pokeapi.co/api/v2/pokemon/";

  PokemonHttpApi(this.client);

  @override
  Future<PokemonDto?> getPokemonById(int id) async {
    try {
      // Dart's 'await' naturally handles async I/O without blocking the UI thread,
      // functionally equivalent to Kotlin's withContext(Dispatchers.IO)
      final response = await client.get(Uri.parse('$baseUrl$id'));

      // runCatching and isSuccessful equivalent: evaluating the HTTP status code
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> jsonMap = jsonDecode(response.body);

        // Result.success equivalent
        return PokemonDto.fromJson(jsonMap);
      } else {
        // Result.failure equivalent for HTTP errors
        throw Exception("Error fetching Pokemon: ${response.statusCode}");
      }
    } catch (e) {
      // Catching network failures (e.g., no internet connection)
      // Equivalent to returning Result.failure(e) in Kotlin
      if (kDebugMode) {
        print("Network error occurred: $e");
      }
      return null;
    }
  }
}
