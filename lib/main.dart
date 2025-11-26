import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Pages/SplashScreen.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Background color
        scaffoldBackgroundColor: Colors.grey.shade900,
        

        // Primary color (for buttons, app bar, etc.)
        primaryColor: const Color.fromARGB(255, 10, 83, 144),

         appBarTheme: AppBarTheme(
       iconTheme: IconThemeData(color: Colors.blueGrey),
      backgroundColor:  Colors.blueGrey,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.blueGrey,
            fontSize: 20,
            fontWeight: FontWeight.bold,
     )),

        // Elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 10, 83, 144),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            minimumSize: const Size(300, 100),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            // خلي حجم الخط للنصوص يتحكم فيها كل ويدجت لوحده
          ),
        ),

        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade800,
          hintStyle: const TextStyle(color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
