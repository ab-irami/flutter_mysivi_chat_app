import 'package:flutter/material.dart';
import 'package:flutter_mysivi_chat_app/core/widgets/message_bubble.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_mysivi_chat_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('BottomNav → Home → Chat History → Chat Screen → Send Message', (
    tester,
  ) async {
    // Launch app
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Wait until splash page exits
    await tester.pumpAndSettle(const Duration(seconds: 3));


    // Ensure BottomNavigationBar exists
    final bottomNav = find.byType(BottomNavigationBar);
    expect(bottomNav, findsOneWidget);

    // Ensure we are on Home tab (index 0)
    // If NOT guaranteed, tap it explicitly
    await tester.tap(
      find.descendant(of: bottomNav, matching: find.byIcon(Icons.home_outlined)),
    );
    await tester.pumpAndSettle();

    // Switch to "Chat History" tab
    expect(find.text('Chat History'), findsOneWidget);

    await tester.tap(find.text('Chat History'));
    await tester.pumpAndSettle();

    // Tap a chat ListTile (by username)
    // Replace 'Alice' with a real username shown in your UI
    final chatTile = find.widgetWithText(ListTile, 'Alice');
    expect(chatTile, findsOneWidget);

    await tester.tap(chatTile);
    await tester.pumpAndSettle();

    // Chat screen opened (AppBar title = username)
    expect(find.text('Alice'), findsOneWidget);

    // Find the TextField (only one on chat screen)
    final inputField = find.byType(TextField);
    expect(inputField, findsOneWidget);

    // Send a message
    await tester.enterText(inputField, 'Hello');
    await tester.pump();

    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    // Verify outgoing message
    expect(find.text('Hello'), findsOneWidget);

    // Typing indicator appears
    expect(find.textContaining('typing'), findsOneWidget);

    // Wait for incoming message
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byType(MessageBubble), findsWidgets);

    // Long-press text to trigger translation
    await tester.longPress(find.text('Hello'));
    await tester.pumpAndSettle();

    // Translation SnackBar appears
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
