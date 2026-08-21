import 'package:flutter/material.dart';
import 'package:pokeflutter/ui/components/error_screen_widget.dart';
import 'package:pokeflutter/ui/components/loading_widget.dart';
import 'package:pokeflutter/ui/components/pokemon_card_widget.dart';
import 'package:pokeflutter/ui/home/pokemon_view_model.dart';
import 'package:pokeflutter/ui/state/pokemon_ui_state.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final pokemonViewModel = Provider.of<PokemonViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        // Style the AppBar with Pokedex Red and White text to match Compose!
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(widget.title), // Left-aligned naturally, no Center wrapper
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                const Text(
                  'Random',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Switch(
                  value: pokemonViewModel.isRandomMode,
                  activeColor: Theme.of(context)
                      .colorScheme
                      .secondary, // Pokeball Blue contrast
                  onChanged: (value) => pokemonViewModel.toggleRandomMode(),
                ),
              ],
            ),
          ),
        ],
      ),
      body: renderBodyContent(pokemonViewModel),
      floatingActionButton: FloatingActionButton(
        // Dynamic action based on selected search mode
        onPressed: pokemonViewModel.isRandomMode
            ? pokemonViewModel.getPokemonRandom
            : pokemonViewModel.getPokemonSequential,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
          child: pokemonViewModel.isRandomMode
              ? const Icon(Icons.shuffle, key: ValueKey('shuffle_icon'))
              : const Icon(Icons.add, key: ValueKey('add_icon')),
        ),
      ),
    );
  }

  Widget renderBodyContent(PokemonViewModel pokemonViewModel) {
    final state = pokemonViewModel.pokemonState;

    // Resolve our localized strings using the BuildContext
    final localizations = AppLocalizations.of(context)!;

    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          );
        },
        child: switch (state) {
          PokemonUiLoading() => const LoadingWidget(
              key: ValueKey('loading_state'),
            ),
          PokemonUiSuccess(pokemon: final data) => PokemonCardWidget(
              key: ValueKey('pokemon_success_${data.id}'),
              pokemon: data,
            ),
          PokemonUiError(message: final errorMsg) => ErrorScreenWidget(
              key: const ValueKey('error_state'),
              // We map the error state to our translated dictionary string
              errorMessage: errorMsg.contains('Connection')
                  ? localizations.connectionError
                  : localizations.noDataFound,
              onRetry: () => pokemonViewModel.getPokemonSequential(),
            ),
        },
      ),
    );
  }
}
