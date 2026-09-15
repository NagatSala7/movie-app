class ReviewModel {
  final String id;
  final String author;
  final String content;
  final double? rating;
  final String? avatarPath;

  ReviewModel({
    required this.id,
    required this.author,
    required this.content,
    this.rating,
    this.avatarPath,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    final authorDetails = json['author_details'] ?? {};
    return ReviewModel(
      id: json['id'] ?? '',
      author: json['author'] ?? 'Anonymous',
      content: json['content'] ?? '',
      rating: authorDetails['rating'] != null
          ? (authorDetails['rating'] as num).toDouble()
          : null,
      avatarPath: authorDetails['avatar_path'],
    );
  }
}