import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_management_app/main.dart';
import 'package:laundry_management_app/screens/login_screen.dart';
import 'package:laundry_management_app/screens/registration_screen.dart';
import 'package:laundry_management_app/screens/home_screen.dart';

void main() {
  testWidgets('Login screen has email and password fields and a login button',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Verify the login screen is shown
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(
        find.byType(TextField), findsNWidgets(2)); // Email and password fields
    expect(find.byType(ElevatedButton), findsOneWidget); // Login button

    // Enter email and password
    await tester.enterText(find.byKey(Key('emailField')), 'test@example.com');
    await tester.enterText(find.byKey(Key('passwordField')), 'password');

    // Tap the login button
    await tester.tap(find.byKey(Key('loginButton')));
    await tester.pump();

    // Add further expectations here to check if navigation or state changes
  });

  testWidgets(
      'Registration screen has email and password fields and a register button',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Navigate to the registration screen
    await tester.tap(find.byKey(Key('goToRegisterButton')));
    await tester.pumpAndSettle();

    // Verify the registration screen is shown
    expect(find.byType(RegistrationScreen), findsOneWidget);
    expect(
        find.byType(TextField), findsNWidgets(2)); // Email and password fields
    expect(find.byType(ElevatedButton), findsOneWidget); // Register button

    // Enter email and password
    await tester.enterText(
        find.byKey(Key('registerEmailField')), 'test@example.com');
    await tester.enterText(
        find.byKey(Key('registerPasswordField')), 'password');

    // Tap the register button
    await tester.tap(find.byKey(Key('registerButton')));
    await tester.pump();

    // Add further expectations here to check if navigation or state changes
  });

  testWidgets('Home screen shows list of laundry items',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Simulate successful login
    await tester.enterText(find.byKey(Key('emailField')), 'test@example.com');
    await tester.enterText(find.byKey(Key('passwordField')), 'password');
    await tester.tap(find.byKey(Key('loginButton')));
    await tester.pumpAndSettle();

    // Verify the home screen is shown
    expect(find.byType(HomeScreen), findsOneWidget);

    // Verify the list of laundry items is shown (this depends on your implementation)
    // For example, check if a ListView or certain items are present
    expect(find.byType(ListView), findsOneWidget);
  });
}
