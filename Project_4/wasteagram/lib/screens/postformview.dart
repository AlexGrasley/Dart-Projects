import 'package:flutter/services.dart';
import 'package:wasteagram/config.dart';

class PostFormView extends StatefulWidget {
  @override
  PostFormViewState createState() => PostFormViewState();
}

class PostFormViewState extends State<PostFormView> {
  final _formKey = GlobalKey<FormState>();
  final post = Post();

  @override
  void initState() {
    super.initState();

    retrieveLocation();
  }

  // utility functions

  // gets current location from the system

  LocationData locationData;

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState(() {});
  }

  // gets image from camera
  File image;
  final picker = ImagePicker();

  void getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    image = File(pickedFile.path);
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(image.path);
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    final url = await storageReference.getDownloadURL();
    post.photoURL = url;
    setState(() {});
  }

  // gets image from gallery
  void getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(image.path);
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    final url = await storageReference.getDownloadURL();
    post.photoURL = url;
    setState(() {});
  }

  // end utility functions

  @override
  Widget build(BuildContext context) {
    // get data passed into widget from Nav route
    final List<String> receivedPost = ModalRoute.of(context).settings.arguments;

    // if data is present, fill local post instance
    if (receivedPost != null) {
      post.date = receivedPost[0];
      post.photoURL = receivedPost[1];
      post.itemCount = int.parse(receivedPost[2]);
      post.locLat = double.parse(receivedPost[3]);
      post.locLong = double.parse(receivedPost[4]);
    }
    // post was empty, fill with blank data
    else {
      post.date =
          "${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().day.toString()}/${DateTime.now().year.toString()}";
      post.photoURL =
          post.photoURL != '' || post.photoURL != null ? post.photoURL : '';
      post.itemCount = 0;
      if (locationData == null) {
        post.locLat = 0.0;
        post.locLong = 0.0;
      } else {
        post.locLat = locationData.latitude;
        post.locLong = locationData.longitude;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Waste from\n" + post.date),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: locationData == null && receivedPost == null
              ? Container(
                  padding: EdgeInsets.all(100),
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
              : Column(children: [
                  wasteImage(context, post),
                  imageCapture(
                      context, getImageFromCamera, getImageFromGallery),
                  locationRow(context, post),
                  itemCountField(context, post),
                  postButton(context, _formKey, post),
                ]),
        ),
      ),
    );
  }
}

// for PHOTO URL
Widget wasteImage(BuildContext context, Post post) {
  if (post.getPhotoURL == "" || post.photoURL == null ) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Placeholder(),
    );
  } else {
    return Container(
      padding: EdgeInsets.all(50),
      child: Image(
              semanticLabel: "Image of food waste items",
              image: NetworkImage(post.getPhotoURL)));
  }
}

// row widget containing buttons for camera and image gallery picker
Widget imageCapture(BuildContext context, Function getImageFromCamera,
    Function getImageFromGallery) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Semantics(
        label: "Launches the camera",
        child: Container(
          width: 100,
          padding: EdgeInsets.all(1),
          child: ElevatedButton(
            child: Icon(Icons.camera),
            onPressed: () {
              getImageFromCamera();
            },
          ))),
      Container(
        width: 50,
      ),
      Semantics(
        label: "Launches the image gallery",
        child: Container(
          width: 100,
          padding: EdgeInsets.all(1),
          child: ElevatedButton(
            child: Icon(Icons.photo_album),
            onPressed: () {
              getImageFromGallery();
            },
          ))),
    ],
  );
}

Widget locationRow(BuildContext context, Post post) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 100,
        padding: EdgeInsets.all(1),
        child: Text(post.getLat.toString()),
      ),
      Container(
        width: 100,
        padding: EdgeInsets.all(1),
        child: Text(post.getLong.toString()),
      ),
    ],
  );
}

// item count widget, tracks number of items and runs validation
// on item number being entered
Widget itemCountField(BuildContext context, Post post) {
  return Container(
    width: 100,
    alignment: Alignment.center,
    child: Semantics(
      label: "Waste Item count, enter a number here",
      child: TextFormField(
      decoration: const InputDecoration(labelText: "Item Count"),
      initialValue: post.itemCount > 0 ? post.itemCount.toString() : '',
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      textAlign: TextAlign.center,
      validator: (value) {
        if (value.isEmpty) {
          return 'Must enter count';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        post.itemCount = int.parse(value);
      },
    )),
  );
}

// button to run form validation and submit waste post to backend db
Widget postButton(
    BuildContext context, GlobalKey<FormState> _formKey, Post post) {
  return Semantics(
    label: "Post button, uploads post to wastegram servers",
    child: Container(
      padding: EdgeInsets.all(5),
      child: ElevatedButton(
        child: Text("Post!"),
        onPressed: () {
          if (_formKey.currentState.validate() &&
              post.locLat != 0 &&
              post.locLong != 0) {
            _formKey.currentState.save();
            FirebaseFirestore.instance.collection('WastePosts').add({
              'Date': post.date,
              'ItemCount': post.itemCount,
              'PhotoURL': post.photoURL,
              'LocLat': post.locLat,
              'LocLong': post.locLong
            });
            Navigator.pushReplacementNamed(context, '/');
          }
        },
      )));
}
