import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/Features/domain/entities/posts/post_entity.dart';

class PostModel extends PostEntity {
  final String? postId;
  final String? creatorUid;
  final String? username;
  final String? description;
  final String? postImageUrl;
  final List<String>? likes;
  final num? totalLikes;
  final num? totalComments;
  final Timestamp? createAt;
  final String? userProfileUrl;

  const PostModel({
    this.postId,
    this.creatorUid,
    this.username,
    this.description,
    this.postImageUrl,
    this.likes,
    this.totalLikes,
    this.totalComments,
    this.createAt,
    this.userProfileUrl,
  }) : super(
          postId: postId,
          creatorUid: creatorUid,
          createAt: createAt,
          username: username,
          description: description,
          postImageUrl: postImageUrl,
          likes: likes,
          totalLikes: totalLikes,
          totalComments: totalComments,
          userProfileUrl: userProfileUrl,
        );

  factory PostModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
      createAt: snapshot['createAt'],
      creatorUid: snapshot['creatorUid'],
      description: snapshot['description'],
      userProfileUrl: snapshot['userProfileUrl'],
      totalLikes: snapshot['totalLikes'],
      totalComments: snapshot['totalComments'],
      postImageUrl: snapshot['postImageUrl'],
      username: snapshot['username'],
      postId: snapshot['postId'],
      likes: List.from(snap.get('likes')),
    );
  }

  Map<String, dynamic> toJson() => {
        "createAt": createAt,
        "creatorUid": creatorUid,
        "description": description,
        "userProfileUrl": userProfileUrl,
        "totalLikes": totalLikes,
        "totalComments": totalComments,
        "postImageUrl": postImageUrl,
        "username": username,
        "postId": postId,
        "likes": likes,
      };
}
