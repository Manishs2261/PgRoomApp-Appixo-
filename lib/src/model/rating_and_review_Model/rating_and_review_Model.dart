class RatingAndReviewModel {
  double? rating;
  String? title;
  String? currentDate;
  String? userId;
  String? userName;
  String? userImage;

  RatingAndReviewModel({this.rating, this.title,this.currentDate,this.userId,this.userName,this.userImage});

  RatingAndReviewModel.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    title = json['title'];
    currentDate = json['currentDate'];
    userId = json['userId'];
    userName = json['userName'];
    userImage = json['userImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['title'] = this.title;
    data['currentDate'] = this.currentDate;
    data['userId'] = this.userId;
    data['userName']= this.userName;
    data['userImage'] = this.userImage;
    return data;
  }
}
