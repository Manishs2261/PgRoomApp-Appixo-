class RatingAndReviewModel {
  double? rating;
  String? title;
  String? currentDate;

  RatingAndReviewModel({this.rating, this.title,this.currentDate});

  RatingAndReviewModel.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    title = json['title'];
    currentDate = json['currentDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['title'] = this.title;
    data['currentDate'] = this.currentDate;
    return data;
  }
}
