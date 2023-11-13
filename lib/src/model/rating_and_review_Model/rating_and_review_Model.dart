class RatingAndReviewModel {
  double? rating;
  String? title;

  RatingAndReviewModel({this.rating, this.title});

  RatingAndReviewModel.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['title'] = this.title;
    return data;
  }
}
