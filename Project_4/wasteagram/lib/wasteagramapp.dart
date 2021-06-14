import 'package:wasteagram/config.dart';
import 'package:wasteagram/routes.dart';

// primary class for wastegram app, stores initial material app for main to run
class WasteagramApp extends StatefulWidget {
  @override
  WasteagramState createState() => WasteagramState();
}

class WasteagramState extends State<WasteagramApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Westeagram",
      theme: ThemeData.dark(),
      routes: Routes.routes,
    );
  }
}
