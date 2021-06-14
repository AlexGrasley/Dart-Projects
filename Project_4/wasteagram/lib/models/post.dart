class Post {
  String date;
  String photoURL;
  int itemCount;
  double locLat;
  double locLong;

  Post({this.date, this.photoURL, this.itemCount, this.locLat, this.locLong});

  String get getDate => this.date;
  String get getPhotoURL => this.photoURL;
  int get getItemCount => this.itemCount;
  double get getLat => this.locLat;
  double get getLong => this.locLong;
}
