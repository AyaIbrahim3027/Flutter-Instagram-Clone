import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/consts.dart';
import 'package:instagram_clone/features/domain/entities/replay/replay_entity.dart';
import 'package:instagram_clone/features/presentation/cubit/replay/replay_cubit.dart';
import 'package:instagram_clone/features/presentation/page/profile/widgets/profile_form_widget.dart';
import 'package:instagram_clone/features/presentation/widgets/button_container_widget.dart';

class EditReplayMainWidget extends StatefulWidget {
  const EditReplayMainWidget({Key? key, required this.replay})
      : super(key: key);
  final ReplayEntity replay;

  @override
  State<EditReplayMainWidget> createState() => _EditReplayMainWidgetState();
}

class _EditReplayMainWidgetState extends State<EditReplayMainWidget> {
  TextEditingController? descriptionController;

  bool isReplayUpdating = false;

  @override
  void initState() {
    descriptionController =
        TextEditingController(text: widget.replay.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: const Text("Edit Replay"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            ProfileFormWidget(
              title: "description",
              controller: descriptionController,
            ),
            sizeVer(10),
            ButtonContainerWidget(
              color: blueColor,
              text: "Save Changes",
              onTapListener: () {
                editReplay();
              },
            ),
            sizeVer(10),
            isReplayUpdating == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Updating...",
                        style: TextStyle(color: Colors.white),
                      ),
                      sizeHor(10),
                      const CircularProgressIndicator(),
                    ],
                  )
                : const SizedBox(
                    width: 0,
                    height: 0,
                  )
          ],
        ),
      ),
    );
  }

  editReplay() {
    setState(() {
      isReplayUpdating = true;
    });
    BlocProvider.of<ReplayCubit>(context)
        .updateReplay(
            replay: ReplayEntity(
                postId: widget.replay.postId,
                commentId: widget.replay.commentId,
                replayId: widget.replay.replayId,
                description: descriptionController!.text))
        .then((value) {
      setState(() {
        isReplayUpdating = false;
        descriptionController!.clear();
      });
      Navigator.pop(context);
    });
  }
}
