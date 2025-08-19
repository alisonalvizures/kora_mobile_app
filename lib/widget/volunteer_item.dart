
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kora_app/views/single_volunteer_screen.dart';
import '../model/user_model.dart';
import '../views/colors.dart';
import '../views/single_chat_screen.dart';

class VolunteerItem extends StatefulWidget {
  const VolunteerItem({super.key, required this.user});

  final UserModel user;

  @override
  State<VolunteerItem> createState() => _VolunteerItemState();
}

class _VolunteerItemState extends State<VolunteerItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) =>
                VolunteerSingleScreen(userId: widget.user.uid))),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                    NetworkImage(widget.user.image),
                  ),
                ],
              ),
              SizedBox(
                width: 250,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: FractionalOffset.centerLeft,
                        child: Text(widget.user.name,
                            style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: darkpurple[500])),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Align(
                        alignment: FractionalOffset.centerLeft,
                        child: Text(widget.user.about,
                          maxLines: 2,
                          style: TextStyle(fontSize: 16,color: gray[500]),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: FractionalOffset.centerLeft,
                        child: Text(widget.user.speciality,
                            style: TextStyle(fontSize: 14,color: lightpink[500])),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        )
    )
  );
}
