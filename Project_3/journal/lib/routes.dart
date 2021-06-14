import 'config.dart';

class Routes {
  static final routes = {
    '/': (context) => OrientationDecider(context),
    'SettingsDrawer': (context) => SettingsDrawer(),
    'JournalApp': (context) => JournalApp(),
    'JournalList': (context) => JournalList(),
    'EntryForm': (context) => EntryForm(context),
  };

  get getRoutes => routes;
}
