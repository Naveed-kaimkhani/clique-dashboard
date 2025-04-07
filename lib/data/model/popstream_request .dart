// models/popstream_request.dart
class PopstreamRequest {
  final int id;
  final int userId;
  final String createdBy;
  final String status;
  final String? name;
  final String showType;
  final String thumbnailUrl;
  final String videoUrl;
  final String createdAt;

  PopstreamRequest({
    required this.id,
    required this.userId,
    required this.createdBy,
    required this.status,
    required this.name,
    required this.showType,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.createdAt,
  });

  factory PopstreamRequest.fromJson(Map<String, dynamic> json) {
    return PopstreamRequest(
      id: json['id'],
      userId: json['user_id'],
      createdBy: json['created_by'],
      status: json['status'],
      name: json['name'],
      showType: json['show_type'],
      thumbnailUrl: json['thumbnail_url'],
      videoUrl: json['video_url'],
      createdAt: json['created_at'],
    );
  }

  // Add this copyWith method
  PopstreamRequest copyWith({
    int? id,
    int? userId,
    String? createdBy,
    String? status,
    String? name,
    String? showType,
    String? thumbnailUrl,
    String? videoUrl,
    String? createdAt,
  }) {
    return PopstreamRequest(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdBy: createdBy ?? this.createdBy,
      status: status ?? this.status,
      name: name ?? this.name,
      showType: showType ?? this.showType,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}