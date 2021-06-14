import 'config.dart';

class OrientationDecider extends StatelessWidget {
  OrientationDecider(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 400, maxHeight: 300, minWidth: 400),
      child: LayoutBuilder(
        builder: chooselayout,
      ),
    );
  }
}

Widget chooselayout(BuildContext context, BoxConstraints constraints) =>
    constraints.maxWidth < 500 ? VerticalLayout() : HorizontalLayout();

class VerticalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return JournalList();
  }
}

class HorizontalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: Expanded(child: JournalList())),
          Expanded(
              child: EntryForm(context),
          ),
        ],
      ),
    );
  }
}
