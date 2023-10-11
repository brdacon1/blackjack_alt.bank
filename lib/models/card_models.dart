class CardModels {
  final bool success;
  final String deckId;
  final List<CardInfo> cards;
  final int remaining;

  CardModels({
    required this.success,
    required this.deckId,
    required this.cards,
    required this.remaining,
  });

  factory CardModels.fromJson(Map<String, dynamic> json) {
    List<CardInfo> cardList = [];
    if (json['cards'] != null) {
      json['cards'].forEach((card) {
        cardList.add(CardInfo.fromJson(card));
      });
    }

    return CardModels(
      success: json['success'],
      deckId: json['deck_id'],
      cards: cardList,
      remaining: json['remaining'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'success': success,
      'deck_id': deckId,
      'cards': cards.map((card) => card.toJson()).toList(),
      'remaining': remaining,
    };
    return data;
  }
}

class CardInfo {
  final String code;
  final String image;
  final CardImages images;
  final String value;
  final String suit;

  CardInfo({
    required this.code,
    required this.image,
    required this.images,
    required this.value,
    required this.suit,
  });

  factory CardInfo.fromJson(Map<String, dynamic> json) {
    return CardInfo(
      code: json['code'],
      image: json['image'],
      images: CardImages.fromJson(json['images']),
      value: json['value'],
      suit: json['suit'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'code': code,
      'image': image,
      'images': images.toJson(),
      'value': value,
      'suit': suit,
    };
    return data;
  }
}

class CardImages {
  final String svg;
  final String png;

  CardImages({
    required this.svg,
    required this.png,
  });

  factory CardImages.fromJson(Map<String, dynamic> json) {
    return CardImages(
      svg: json['svg'],
      png: json['png'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'svg': svg,
      'png': png,
    };
    return data;
  }
}
