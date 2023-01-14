import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'home.dart';
import 'search.dart';
import 'bookmark.dart';
import 'profile.dart';

class PostPage extends StatefulWidget {
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _cookTimeController = TextEditingController();
  final TextEditingController _servingSizeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _stepController = TextEditingController();

  File? _image;

  Future getImage() async {
    PickedFile? image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    setState(() {
      _image = File(image!.path);
    });
  }

  String postId = const Uuid().v1();

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseStorage.instance
        .ref()
        .child('posts/${FirebaseAuth.instance.currentUser?.uid}/$postId}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.black,
            )),
        title: const Text(
          'Add Receipe',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                await ref.putFile(_image!);

                String photoUrl = await ref.getDownloadURL();

                DocumentSnapshot snap = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get();
                String username = snap['username'];
                String fullname = snap['fullname'];

                FirebaseFirestore.instance
                    .collection('posts')
                    .doc(postId) //postID
                    .set({
                  "postId": postId,
                  "uid": FirebaseAuth.instance.currentUser?.uid,
                  "recipename": _recipeNameController.text,
                  "cooktime": _cookTimeController.text,
                  "servingsize": _servingSizeController.text,
                  "description": _descriptionController.text,
                  "ingredients": _ingredientController.text,
                  "steps": _stepController.text,
                  "photoUrl": photoUrl,
                  "username": username,
                  "fullname": fullname,
                });

                print('New Post Created!');
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Posted')));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ))
        ],
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //  image pick
                _image == null
                    ? Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: IconButton(
                            icon: const Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 50,
                            ),
                            onPressed: () async {
                              getImage();
                            }),
                      )
                    : Image.file(
                        _image!,
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.fill,
                      ),
                Column(
                  children: [
                    // recipe name
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: TextField(
                        controller: _recipeNameController,
                        decoration: const InputDecoration(
                          hintText: "Recipe Name ...",
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    // cook time
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: TextField(
                        controller: _cookTimeController,
                        decoration: const InputDecoration(
                          hintText: "Cooking Time ...",
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    // serving size
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: TextField(
                        controller: _servingSizeController,
                        decoration: const InputDecoration(
                          hintText: "Serving Size ...",
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            Column(
              children: <Widget>[
                //little decscription
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Description',
                      style: TextStyle(fontSize: 18),
                      //textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextField(
                    maxLines: 4,
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: "Description ... ",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Divider(),
                // Ingredients
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ingredients',
                      style: TextStyle(fontSize: 18),
                      //textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextField(
                    maxLines: 7,
                    controller: _ingredientController,
                    decoration: const InputDecoration(
                      hintText:
                          "ex. \n - 1 whole egg \n - 2 cups of white rice \n - 2 tbsp soy sauce",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Divider(),
                // steps
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Steps',
                      style: TextStyle(fontSize: 18),
                      //textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextField(
                    maxLines: 9,
                    controller: _stepController,
                    decoration: const InputDecoration(
                      hintText:
                          "ex. \n1. Put pan on stove, on high heat \n2. Drizzle oil to cover the pan \n3. Crack the egg onto the pan",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            const Spacer(),
            // home
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                icon: const Icon(Icons.home)),
            const Spacer(),
            // search
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                icon: const Icon(Icons.search)),
            const Spacer(),
            // recipe post
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostPage()),
                  );
                },
                icon: const Icon(Icons.restaurant_menu)),
            const Spacer(),
            // saved
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookMarkPage()),
                  );
                },
                icon: const Icon(Icons.bookmark)),
            const Spacer(),
            // profile
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                icon: const Icon(Icons.person_sharp)),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
