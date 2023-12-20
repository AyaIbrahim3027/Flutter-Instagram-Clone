import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/domain/entities/replay/replay_entity.dart';

class ReplayModel extends ReplayEntity {
  @override
  final String? creatorUid;
  @override
  final String? replayId;
  @override
  final String? commentId;
  @override
  final String? postId;
  @override
  final String? description;
  @override
  final String? username;
  @override
  final String? userProfileUrl;
  @override
  final List<String>? likes;
  @override
  final Timestamp? createAt;

  ReplayModel({
    this.creatorUid,
    this.replayId,
    this.commentId,
    this.postId,
    this.description,
    this.username,
    this.userProfileUrl,
    this.likes,
    this.createAt,
  }) : super(
            description: description,
            commentId: commentId,
            postId: postId,
            creatorUid: creatorUid,
            userProfileUrl: userProfileUrl,
            username: username,
            likes: likes,
            createAt: createAt,
            replayId: replayId);

  factory ReplayModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ReplayModel(
      postId: snapshot['postId'],
      creatorUid: snapshot['creatorUid'],
      description: snapshot['description'],
      userProfileUrl: snapshot['userProfileUrl'],
      commentId: snapshot['commentId'],
      replayId: snapshot['replayId'],
      createAt: snapshot['createAt'],
      username: snapshot['username'],
      likes: List.from(snap.get("likes")),
    );
  }

  Map<String, dynamic> toJson() => {
        "creatorUid": creatorUid,
        "description": description,
        "userProfileUrl": userProfileUrl,
        "commentId": commentId,
        "createAt": createAt,
        "replayId": replayId,
        "postId": postId,
        "likes": likes,
        "username": username,
      };
}
