import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool like = true;
  bool save = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
              .copyWith(right: 0),
          child: Row(children: <Widget>[
            //show user name
            Text(
              widget.snap['username'].toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ]),
        ),
        //show image
        GestureDetector(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                child: Image.network(
                  widget.snap['photoUrl'].toString(),
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    return child;
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                  height: 430,
                  width: 430,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        //add row of heart, cook, send( share), save
        Row(
          children: <Widget>[
            //like
            IconButton(
                onPressed: () {
                  setState(() {
                    like = !like;
                  });
                },
                icon: Icon(
                    (like == false) ? Icons.favorite : Icons.favorite_border)),
            //cook
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                            title: Text('Start Cooking'),
                            content: Column(
                              children: [
                                Text(
                                  "Ingredients:",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Text(widget.snap['ingredients'].toString()),
                                Text(
                                  "Instructions:",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Text(
                                  widget.snap['steps'].toString(),
                                )
                              ],
                            ));
                      });
                },
                icon: Icon(Icons.restaurant)),
            //save
            IconButton(
                onPressed: () {
                  setState(() {
                    save = !save;
                  });
                },
                icon: Icon(
                    (save == false) ? Icons.bookmark : Icons.bookmark_border)),
            // send
            IconButton(onPressed: () {}, icon: Icon(Icons.send_outlined)),
          ],
        ),
        // add content show only recipe name, srving size, and cook time, and description
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.topLeft,
          child: Row(children: [
            Text(
              widget.snap['recipename'].toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              //textAlign: TextAlign.left,
            ),
            Spacer(),
            Icon(Icons.access_alarm),
            Text(
              widget.snap['cooktime'].toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(Icons.group),
            Text(
              widget.snap['servingsize'].toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
        //description
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            widget.snap['description'].toString(),
          ),
        ),
        const Divider(),
      ]),
    );
  }
}
