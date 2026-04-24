import 'package:flutter/material.dart';
import 'package:pokeflutter/ui/home/pokemon_view_model.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var pokemonViewModel = Provider.of<PokemonViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: renderBodyContent(pokemonViewModel),
      floatingActionButton: FloatingActionButton(
        onPressed: pokemonViewModel.getPokemonImage,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget renderBodyContent(PokemonViewModel pokemonViewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (pokemonViewModel.urlState.isNotEmpty)
            Image.network(pokemonViewModel.urlState),
        ],
      ),
    );
  }
}
