class JournalEntry {
  String title;
  String body;
  String rating;
  DateTime date;

  JournalEntry({this.title, this.body, this.rating, this.date});

  get getTitle => this.title;
  get getBody => this.body;
  get getRating => this.rating;
  get getDate => this.date;
}
