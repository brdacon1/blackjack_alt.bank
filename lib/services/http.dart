import 'package:dio/dio.dart';

Dio dio() {
  BaseOptions params = BaseOptions(
    baseUrl: "https://www.deckofcardsapi.com",
  );
  Dio dio = Dio(params);
  return dio;
}

class Http {
  static final Dio _dio = dio();

  static createNewDeck() async {
    return await _dio.get(
      "/api/deck/new",
      options: Options(
      ),
    );
  }

  static shuffleCards(String? deckCount) async {
    return await _dio.get(
      "/api/deck/new/shuffle/?deck_count=$deckCount",
      options: Options(
      ),
    );
  }

  static reShuffleCards(String? deckId) async {
    return await _dio.get(
      "/api/deck/$deckId/shuffle/?remaining=true",
      options: Options(
      ),
    );
  }

  static buyCards(String? deckId) async {
    return await _dio.get(
      "/api/deck/$deckId/draw/?count=1",
      options: Options(
      ),
    );
  }

  static addPiles(String? deckId, List<dynamic> cardList, String? pileName) async {
    String cards = "";

    for (int i = 0; i < cardList.length; i++) {
      if (i == cardList.length - 1) {
        cards += "${cardList[i]}";
      } else {
        cards += "${cardList[i]},";
      }
    }

    return await _dio.get(
      "/$deckId/pile/$pileName/add/?cards=$cards",
      options: Options(),
    );
  }

  static shufflePiles(String? deckId, String? pileName) async {
    return await _dio.get(
      "/api/deck/$deckId/pile/$pileName/shuffle",
      options: Options(),
    );
  }

}