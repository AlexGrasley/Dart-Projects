import 'config.dart';

class JournalApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  JournalAppState createState() => JournalAppState();
}

class JournalAppState extends State<JournalApp> {
  bool isDark;

  void initState() {
    super.initState();
    isDark = false;
    initTheme();
  }

  void initTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDark = prefs.getBool('isDark') ?? false;      
        });
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal',
      theme: isDark == false ? ThemeData.light() : ThemeData.dark(),
      routes: Routes.routes,
    );
  }
}
