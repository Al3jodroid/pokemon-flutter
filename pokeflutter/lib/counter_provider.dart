import 'package:flutter/material.dart';

class CounterProvider with ChangeNotifier {
  //Attributes to manage our business
  int _counter;
  int get counter => _counter;

  //Custom parametrizable constructor
  CounterProvider(this._counter);

  //finally! the business separated from UI
  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
}
