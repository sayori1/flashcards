class CardModel {
  String term;
  String definition;
  bool memorized;
  CardModel(
      {required this.term, required this.definition, this.memorized = false});
  factory CardModel.fromJson(json) {
    return CardModel(
        term: json['term'],
        definition: json['definition'],
        memorized: json['memorized']);
  }
  Map toJson() {
    return {"term": term, "definition": definition, "memorized": memorized};
  }
}
