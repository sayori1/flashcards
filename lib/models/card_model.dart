class CardModel {
  String term;
  String definition;
  bool get memorized => correct>3+incorrect;

  int correct;
  int incorrect;

  CardModel(
      {required this.term, required this.definition, this.correct = 0, this.incorrect = 0});
  factory CardModel.fromJson(json) {
    return CardModel(
        term: json['term'],
        definition: json['definition'],
        correct: json['correct'],
        incorrect: json['incorrect']
        );
  }
  Map toJson() {
    return {"term": term, "definition": definition, "correct": correct, "incorrect": incorrect};
  }
}
