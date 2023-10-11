class AddPileModels {
  final bool success;
  final String deckId;
  final int remaining;
  final Map<String, Map<String, int>> piles;

  AddPileModels({
    required this.success,
    required this.deckId,
    required this.remaining,
    required this.piles,
  });

  factory AddPileModels.fromJson(Map<String, dynamic> json) {
    Map<String, Map<String, int>> piles = {};
    if (json['piles'] != null) {
      json['piles'].forEach((key, value) {
        piles[key] = Map<String, int>.from(value);
      });
    }

    return AddPileModels(
      success: json['success'],
      deckId: json['deck_id'],
      remaining: json['remaining'],
      piles: piles,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonPiles = {};
    piles.forEach((key, value) {
      jsonPiles[key] = value;
    });

    return {
      'success': success,
      'deck_id': deckId,
      'remaining': remaining,
      'piles': jsonPiles,
    };
  }
}
