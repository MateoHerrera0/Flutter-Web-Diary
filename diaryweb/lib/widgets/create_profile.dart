import 'package:diaryweb/model/user.dart';
import 'package:diaryweb/screens/login_page.dart';
import 'package:diaryweb/services/service.dart';
import 'package:diaryweb/widgets/update_user_profile_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateProfile extends StatelessWidget {
  const CreateProfile({
    Key? key,
    required this.curUser,
  }) : super(key: key);

  final MUser curUser;

  @override
  Widget build(BuildContext context) {
    Map<String, String> headersMap = {"Access-Control-Allow-Origin": "*"};
    final _avatarUrlTextController =
        TextEditingController(text: curUser.avatarUrl);
    final _displayNameTextController =
        TextEditingController(text: curUser.displayName);
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(curUser.avatarUrl!, headers: headersMap),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return UpdateUserProfileDialog(
                            curUser: curUser,
                            avatarUrlTextController: _avatarUrlTextController,
                            displayNameTextController:
                                _displayNameTextController);
                      },
                    );
                  },
                ),
              ),
              Text(
                curUser.displayName!,
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  return Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                });
              },
              icon: Icon(
                Icons.logout_outlined,
                size: 19,
                color: Colors.redAccent,
              ))
        ],
      ),
    );
  }
}
