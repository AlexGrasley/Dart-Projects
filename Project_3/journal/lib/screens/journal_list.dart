import 'package:journal/config.dart';

class JournalList extends StatefulWidget {
  @override
  JournalListState createState() => JournalListState();
}

class JournalListState extends State<JournalList> {
  void initState() {
    super.initState();
    loadJournal();
  }

  @override
  void didUpdateWidget(JournalList JournalListView) {
    super.didUpdateWidget(JournalListView);
    loadJournal();
  }

  var journalList;

  void loadJournal() async {
    // open database, create if not there
    Database db = await openDatabase('journal.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS journal_entries(id INTEGER PRIMARY KEY, title TEXT, body TEXT, rating TEXT)');
    });

    // get all records from journal database table
    List<Map> journalRecords =
        await db.rawQuery('SELECT * FROM journal_entries');

    // convert the records to a list of entryformmodel objects
    final journalEntries = journalRecords.map((record) {
      return JournalEntry(
          title: record['title'],
          body: record['body'],
          rating: record['rating']);
    }).toList();

    setState(() {
      journalListView(context, journalEntries);
      journalList = journalEntries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Journal Entries"),
        ),
        body: journalList == null
            ? Center(child: CircularProgressIndicator())
            : journalListView(context, journalList),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('EntryForm');
          },
          child: Icon(Icons.add),
        ),
        endDrawer: SettingsDrawer());
  }

  Widget journalListView(BuildContext context, List<JournalEntry> journal) {
    if (journal == null || journal.length == 0) {
      return Container(
                padding: EdgeInsets.all(50),
                alignment: Alignment.center,
                child: Icon(Icons.book, size: 200,),);
    } else {
      return Container(
        child:ListView.builder(
          itemCount: journal.length ?? 0,
          itemBuilder: (context, index) {
            return ListTile(
                leading: FlutterLogo(),
                trailing: Icon(Icons.more_horiz),
                title: Text('${journal[index].title}'),
                subtitle: Text('${journal[index].body}'),
                onTap: () {
                  Navigator.of(context).pushNamed('EntryForm', arguments: [
                    journal[index].title,
                    journal[index].rating,
                    journal[index].body,
                  ]);
                });
          }));
    }
  }
}
