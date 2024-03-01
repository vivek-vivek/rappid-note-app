import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MVC/controller/providers/notes_provider.dart';
import 'MVC/view/dashbord_screen.dart';
import 'package:firebase_core/firebase_core.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAGEn3YSS50XrrtPToAN9hEjLQlGmEYZM8",
      appId: "1:801141838902:android:de1f58c0b7a009b4657497",
      projectId: "fir-projects-fa130",
      messagingSenderId: '',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotesProvider>(
      create: (context) => NotesProvider(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter note app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const DashboardScreen(),
      ),
    );
  }
}
