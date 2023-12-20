class RatingAndReviewModel {
  double? rating;
  String? title;
  String? currentDate;
  String? userId;
  String? userName;
  String? userImage;
  double? tiffineRating;
  String? tiffineTitle;
  String? tiffineUserId;

  RatingAndReviewModel(
      {this.rating,
      this.title,
      this.currentDate,
      this.userId,
      this.userName,
      this.userImage,
      this.tiffineRating,
      this.tiffineTitle,
      this.tiffineUserId});

  RatingAndReviewModel.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    title = json['title'];
    currentDate = json['currentDate'];
    userId = json['userId'];
    userName = json['userName'];
    userImage = json['userImage'];
    tiffineUserId = json['tiffineUserId'];
    tiffineTitle = json['tiffineTitle'];
    tiffineRating = json['tiffineRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['title'] = this.title;
    data['currentDate'] = this.currentDate;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['tiffineRating'] = this.tiffineRating;
    data['tiffineTitle'] = this.tiffineTitle;
    data['tiffineUserId'] = this.tiffineUserId;
    return data;
  }
}
