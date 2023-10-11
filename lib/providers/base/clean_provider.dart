import 'package:blackjack/providers/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../deck.dart';

Function cleanProviders = (BuildContext context){
  Provider.of<Game>(context, listen: false).cleanProvider();
  Provider.of<Deck>(context, listen: false).cleanProvider();
};