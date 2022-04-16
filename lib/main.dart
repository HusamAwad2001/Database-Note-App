import 'package:database/screens/contacts_screen.dart';
import 'package:database/screens/create_contact_screen.dart';
import 'package:database/screens/launch_screen.dart';
import 'package:database/storage/dp_provider.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DBProvider().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => LaunchScreen(),
        '/contacts_screen': (context) => ContactsScreen(),
        '/create_contacts': (context) => CreateContactScreen(),
      },
    );
  }
}
