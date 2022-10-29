// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kimmy/core/utils/encrypt.dart';
import 'package:kimmy/core/utils/json_factory.dart';
import 'package:kimmy/data/model/server_info.dart';

import 'package:kimmy/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget( MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  test("test encrypt", () {
    final eText = encrypt("""-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
""");
    final dText = decrypt(eText);

    print("eText: $eText");
    print("dText: $dText");
  });

  test("text regExp",(){
    final ipRegExp = RegExp(
        r"^((?!-)[A-Za-z0-9-]{1,63}(?<!-)\.)+[A-Za-z]{2,6}$");
    var domainList = [
      "asdasdasdasd",
      "AAAA.aaa",
      "asdasdasd.asdasdasd",
      "123123123123.123123123123",
      "google.com",
      "123.123.123.123",
      "123.123.123",
      "123...123123.123",
      "123.123.123.123.",
      "123.222.255.256",
      '255.255.255.257',
      '255.255.255.255',
      "20.234.25.3"
    ];
    for (var domain in domainList) {
      if(ipRegExp.hasMatch(domain)){
        print("$domain\n");
      }
      // print("$domain\n");
    }
  });

  test("type", ()=> JsonFactory.fromJson<ServerInfo>({}));
}


