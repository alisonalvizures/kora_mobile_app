import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/tracking_model.dart';
import '../views/colors.dart';
import '../views/single_blog_screen.dart';

class BuildTrackingItem extends StatefulWidget {
  const BuildTrackingItem({super.key, required this.tracking});

  final TrackingModel tracking;

  @override
  State<BuildTrackingItem> createState() => _BuildTrackingItemState();
}

class _BuildTrackingItemState extends State<BuildTrackingItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ClipRRect(
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
                SizedBox(
                  width: 320,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(widget.tracking.status,
                            maxLines: 3,
                            style: TextStyle(fontSize: 16,color: gray[500]),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(widget.tracking.dateTime.toString(),
                            maxLines: 3,
                            style: TextStyle(fontSize: 16,color: gray[500]),),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          )
      );
}
