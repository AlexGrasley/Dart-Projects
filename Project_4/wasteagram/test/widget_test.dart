// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/config.dart';

void main() {
test('Ensure post created from constructor works', () {
      final date = DateTime.now().toString();
      final url = 'FAKEURL';
      final count = 10;
      final lat = 3.25;
      final long = 4.25;

      final post = Post(
          date: date,
          photoURL: url,
          itemCount: count,
          locLat: lat,
          locLong: long);

      expect(post.date, date);
      expect(post.photoURL, url);
      expect(post.itemCount, count);
      expect(post.locLat, lat);
      expect(post.locLong, long);
    });
}
