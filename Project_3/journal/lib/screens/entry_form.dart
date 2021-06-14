import 'package:journal/config.dart';

class EntryForm extends StatefulWidget {
  EntryForm(BuildContext context);

  @override
  _EntryFormState createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  final _formKey = GlobalKey<FormState>();
  final entryForm = JournalEntry();
  String rating;

  void initState() {
    super.initState();
    rating = "1";
  }

  void updateRating() {
    setState(() {
      rating = entryForm.rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> receivedValue =
        ModalRoute.of(context).settings.arguments;

    // prefill entry form with values if present.
    if (receivedValue != null) {
      entryForm.title = receivedValue[0];
      entryForm.rating = receivedValue[1];
      entryForm.body = receivedValue[2];
    } else {
      entryForm.title = '';
      entryForm.rating = '1';
      entryForm.body = '';
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("New Journal Entry"),
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Container(
                  child: Column(children: <Widget>[
                    titleField(entryForm),
                    ratingField(entryForm, rating, updateRating),
                    bodyField(entryForm),
                    saveBut(context, _formKey, entryForm),
                  ]),
                ))));
  }
}

Widget titleField(JournalEntry entryForm) {
  return Padding(
    padding: EdgeInsets.all(20),
    child: TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.note_outlined),
        labelText: 'Title*',
      ),
      initialValue: entryForm.title,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a title';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        entryForm.title = value;
      },
    ),
  );
}

Widget ratingField(
    JournalEntry entryForm, String rating, Function() updateRating) {
  return Padding(
    padding: EdgeInsets.all(20),
    child: DropdownButtonFormField<String>(
      value: entryForm.rating,
      items: [
        DropdownMenuItem<String>(value: "1", child: Text("1")),
        DropdownMenuItem<String>(value: "2", child: Text("2")),
        DropdownMenuItem<String>(value: "3", child: Text("3")),
        DropdownMenuItem<String>(value: "4", child: Text("4")),
        DropdownMenuItem<String>(value: "5", child: Text("5")),
      ],
      decoration: const InputDecoration(
        icon: Icon(Icons.note_outlined),
        labelText: 'Rating*',
      ),
      validator: (value) {
        return null;
      },
      onSaved: (String value) {
        entryForm.rating = value;
      },
      onChanged: (String value) {
        entryForm.rating = value;
        updateRating();
      },
    ),
  );
}

Widget bodyField(JournalEntry entryForm) {
  return Padding(
    padding: EdgeInsets.all(20),
    child: TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.note_outlined),
        labelText: 'Note*',
      ),
      initialValue: entryForm.body,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a note';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        entryForm.body = value;
      },
    ),
  );
}

Widget saveBut(BuildContext context, GlobalKey<FormState> _formKey,
    JournalEntry entryForm) {
  return ElevatedButton(
    child: Text("Save"),
    onPressed: () async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        entryForm.date = DateTime.now();

        var db = await openDatabase('journal.db', version: 1,
            onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE IF NOT EXISTS journal_entries(id INTEGER PRIMARY KEY, title TEXT, body TEXT, rating TEXT');
        });

        await db.transaction((txn) async {
          await txn.rawInsert(
              'INSERT INTO journal_entries(title, body, rating) VALUES(?, ?, ?)',
              [entryForm.title, entryForm.body, entryForm.rating]);
        });

        await db.close();

        Navigator.pushNamedAndRemoveUntil(context,'JournalList', (_) => false);
      }
    },
  );
}
