class DeckCards {
  final bool success;
  final String deckId;
  final bool shuffled;
  final int remaining;

  DeckCards({
    required this.success,
    required this.deckId,
    required this.shuffled,
    required this.remaining,
  });

  factory DeckCards.fromJson(Map<String, dynamic> json) {
    return DeckCards(
      success: json['success'],
      deckId: json['deck_id'],
      shuffled: json['shuffled'],
      remaining: json['remaining'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'deck_id': deckId,
      'shuffled': shuffled,
      'remaining': remaining,
    };
  }
}
