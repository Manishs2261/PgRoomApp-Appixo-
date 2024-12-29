class ReviewModel {
  String? date;
  String? review;
  String? rating;
  String? user;

  ReviewModel({this.date, this.review, this.rating, this.user});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    review = json['review'];
    rating = json['rating'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['user'] = this.user;
    return data;
  }
}
