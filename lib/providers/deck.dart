import 'package:blackjack/models/card_models.dart';
import 'package:blackjack/models/deck_cards_models.dart';
import 'package:dio/dio.dart';
import '../models/add_pile_models.dart';
import '../services/http.dart';
import 'base/base_provider.dart';

class Deck extends BaseProvider {
  late CardModels? cardModels;
  late AddPileModels? addPileModels;

  Future<DeckCards?> getNewDeck() async {
    try {
      final result = await Http.createNewDeck();
      return DeckCards.fromJson(result.data);
    } on DioException catch (error) {
      cardModels = null;
      addPileModels = null;
      rethrow;
    } catch (error) {
      cleanProvider();
      rethrow;
    } finally {
      notifyListeners();
    }
  }

 Future<DeckCards?> getShuffleCards(String? deckCount) async {
   try {
     final result = await Http.shuffleCards(deckCount);
     return DeckCards.fromJson(result.data);
   } on DioException catch (error) {
     cleanProvider();
     rethrow;
   } catch (error) {
     rethrow;
   } finally {
     notifyListeners();
   }
 }

 Future<DeckCards?> getReshuffleCards(String? deckId) async {
   try {
     final result = await Http.reShuffleCards(deckId);
     return DeckCards.fromJson(result.data);
   } on DioException catch (error) {
     cleanProvider();
     rethrow;
   } catch (error) {
     rethrow;
   } finally {
     notifyListeners();
   }
 }

 Future<CardModels?> getBuyCards(String? deckId) async {
   try {
     final result = await Http.buyCards(deckId);
     cardModels = CardModels.fromJson(result.data);
     return cardModels;
   } on DioException catch (error) {
     cleanProvider();
     print(error);
     rethrow;
   } catch (error) {
     rethrow;
   } finally {
     notifyListeners();
   }
 }

  Future<AddPileModels?> getAddPiles(String? deckId, List<dynamic> cardList, String? pileName) async {
    try {
      final result = await Http.addPiles(deckId, cardList, pileName);
      addPileModels = AddPileModels.fromJson(result.data);
      return addPileModels;
    } on DioException catch (error) {
      cleanProvider();
      rethrow;
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<AddPileModels?> getShufflePiles(String? deckId, String? pileName) async {
    try {
      final result = await Http.shufflePiles(deckId, pileName);
      addPileModels = AddPileModels.fromJson(result.data);
      return addPileModels;
    } on DioException catch (error) {
      cleanProvider();
      rethrow;
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  @override
  void cleanProvider() {
    cardModels = null;
    addPileModels = null;
  }
}