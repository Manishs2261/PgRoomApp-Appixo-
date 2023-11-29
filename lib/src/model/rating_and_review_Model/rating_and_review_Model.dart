class RatingAndReviewModel {
  double? rating;
  String? title;
  String? currentDate;
  String? userId;

  RatingAndReviewModel({this.rating, this.title,this.currentDate,this.userId});

  RatingAndReviewModel.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    title = json['title'];
    currentDate = json['currentDate'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['title'] = this.title;
    data['currentDate'] = this.currentDate;
    data['userId'] = this.userId;
    return data;
  }
}
