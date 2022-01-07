import 'card_model.dart';

class SetModel {
  String name;
  String description;
  List<CardModel> cards;

  int getCountOfMemorizedCards() {
    int count = 0;
    for (var card in cards) {
      count += card.memorized ? 1 : 0;
    }
    return count;
  }

  SetModel(
      {required this.name, required this.description, this.cards = const []});
  factory SetModel.fromJson(json) {
    List<CardModel> parsedCards = [];
    for (var jsonCard in json['cards']) {
      parsedCards.add(CardModel.fromJson(jsonCard));
    }

    return SetModel(
        name: json['name'],
        description: json['description'],
        cards: parsedCards);
  }
  Map toJson() {
    List<Map> jsonCards = [];
    for (var card in cards) {
      jsonCards.add(card.toJson());
    }

    return {"name": name, "description": description, "cards": jsonCards};
  }
}
