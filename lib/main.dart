import 'package:arrived_at_work/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ArrivedAtWork());
}

class ArrivedAtWork extends StatelessWidget {
  const ArrivedAtWork({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF645199)),
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          centerTitle: true,
        ),
        textTheme: GoogleFonts.notoSerifTextTheme(),
      ),
      home: Home(screenWidth: screenWidth),
    );
  }
}
