class Post {
  String id;
  String avatar;
  String time;
  String comment;
  String foodImage;

  Post({
    required this.id,
    required this.avatar,
    required this.time,
    required this.comment,
    required this.foodImage
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      avatar: json['profileImageUrl'],
      time: json['timestamp'],
      comment: json['comment'],
      foodImage: json['foodPictureUrl'],
    );
  }
}