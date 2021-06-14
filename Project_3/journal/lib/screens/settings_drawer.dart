import 'package:journal/config.dart';

class SettingsDrawer extends StatefulWidget {
  SettingsDrawer({Key key}) : super(key: key);

  @override
  _SettingsDrawerState createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  

  @override
  Widget build(BuildContext context) {
    final JournalAppState appState =
        context.findAncestorStateOfType<JournalAppState>();

        bool _toggled = appState.isDark == false ? false : true;

    void setTheme(bool value) async {
      setState(() => _toggled = value);
      appState.setState(() => appState.isDark = value);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isDark', value);
    }

    return Drawer(
        child: ListView(children: [
      DrawerHeader(child: Text("Settings")),
      SwitchListTile(
        title: Text("Dark Theme"),
        value: _toggled,
        onChanged: (bool value) {
          setTheme(value);
        },
      ),
    ]));
  }
}
