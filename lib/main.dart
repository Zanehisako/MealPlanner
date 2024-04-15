import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tp/models/day_meals.dart';
import 'package:tp/models/meal.dart';
import 'package:tp/screens/add_new_meal_page.dart';
import 'package:tp/screens/details_page.dart';
import 'package:tp/screens/ingrediant_page.dart';
import 'package:tp/screens/login_page.dart';
import 'package:tp/screens/signup_page.dart';
import 'screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Quand on utlise Hive.init on besion de donner un Directoir mais avec Hive.initFlutter On besion pas
  //final appDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter();
  Hive.registerAdapter(MealAdapter());
  Hive.registerAdapter(DayMealsAdapter());
  await Hive.deleteFromDisk();
  await Hive.openBox<DayMeals>('DayMeals');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Meal Planner ',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.orange,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.orange),
        ),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return const MyHomePage();
            } else {
              return LoginPage();
            }
          }),
      routes: {
        'DetailsPage': (contex) => DetailsPage(),
        'AddMealPage': (contex) => AddNewMealPage(),
        'Login_Page': (contex) => LoginPage(),
        'Sign_page': (contex) => SignUp(),
        'Home_page': (contex) => const MyHomePage(),
        'Ingrediants_page': (contex) => IngrediantPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
