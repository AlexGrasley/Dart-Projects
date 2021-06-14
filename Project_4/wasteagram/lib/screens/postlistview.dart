import 'package:wasteagram/config.dart';

class PostListView extends StatefulWidget {
  @override
  PostListViewState createState() => PostListViewState();
}

class PostListViewState extends State<PostListView> {
  int wasteCount;

  void initState() {
    super.initState();
    getWasteCount();
  }


  void getWasteCount() async {
    int count = 0;
    await FirebaseFirestore.instance
        .collection('WastePosts')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((item) {
        count += item['ItemCount'];
      });
    });

    setState(() {
      wasteCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wasteagram"),
        leading: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            child: Text(wasteCount.toString())),
      ),
      body: postListStream(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Semantics(
          label: "Create new Waste Post",
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed('PostFormView');
            },
            child: Icon(Icons.camera_alt),
          )),
    );
  }
}

// DUMMY LIST
List<Post> listPosts = [
  Post(
      date: DateTime.now().toString(),
      photoURL: "",
      itemCount: 3,
      locLat: 0,
      locLong: 0)
];

Widget postListStream(BuildContext context) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection('WastePosts').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            var post = snapshot.data.documents[index];
            return ListTile(
                title: Text(post['Date'].toString()),
                trailing: Text(post['ItemCount'].toString()),
                onTap: () {
                  Navigator.of(context).pushNamed('PostFormView', arguments: [
                    post['Date'].toString(),
                    post['PhotoURL'].toString(),
                    post['ItemCount'].toString(),
                    post['LocLat'].toString(),
                    post['LocLong'].toString(),
                  ]);
                });
          },
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

Widget postList(BuildContext context) {
  return ListView.builder(
    itemCount: listPosts.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(listPosts[index].date.toString()),
        subtitle: Text(listPosts[index].itemCount.toString()),
        onTap: () {
          Navigator.of(context).pushNamed('PostFormView', arguments: [
            listPosts[index].date.toString(),
            listPosts[index].photoURL.toString(),
            listPosts[index].itemCount.toString(),
            listPosts[index].locLat.toString(),
            listPosts[index].locLong.toString(),
          ]);
        },
      );
    },
  );
}
