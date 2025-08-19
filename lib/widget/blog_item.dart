import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/blog_model.dart';
import '../views/colors.dart';
import '../views/single_blog_screen.dart';

class BlogItem extends StatefulWidget {
  const BlogItem({super.key, required this.blog});

  final BlogModel blog;

  @override
  State<BlogItem> createState() => _BlogItemState();
}

class _BlogItemState extends State<BlogItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) =>
                  BlogSingleScreen(blogId: widget.blog.uid))),
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
                SizedBox(
                  width: 320,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(widget.blog.title,
                              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: gray[500])),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(DateFormat('EEEE, d MMMM y').format(widget.blog.dateTime),
                            style: TextStyle(fontSize: 14,color: lightpink[500]),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(widget.blog.content,
                            maxLines: 3,
                            style: TextStyle(fontSize: 16,color: gray[500]),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text('Leer más',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14,color: darkpurple[500], decoration: TextDecoration.underline),),
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
