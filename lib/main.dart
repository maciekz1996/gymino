import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import './globals.dart';
import './providers/trainers_provider.dart';
import './providers/workouts_provider.dart';
import './screens/home_screen.dart';
import './screens/trainer_workouts_screen.dart';
import './screens/workout_overview_screen.dart';
import './screens/workout_screen.dart';
import './screens/exercise_overview_screen.dart';
import './screens/trainer_info_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: TrainersProvider(),
        ),
        ChangeNotifierProvider.value(
          value: WorkoutsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'SQILLY',
        theme: ThemeData(
          primarySwatch: MaterialColor(0xFF1A1A1A, Global().primaryColor),
          accentColor: Color.fromRGBO(224, 22, 22, 1),
          fontFamily: 'Roboto',
          textTheme: TextTheme(
            // TOP TRAINER NAME
            title: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.7,
              color: Colors.white,
            ),
            headline: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              color: Colors.white,
            ),
            // TRAINER CARD NAME
            display1: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
            // EXERCISE NAME (WORKOUT OVERVIEW)
            display2: TextStyle(
              fontSize: 15,
              color: Color.fromRGBO(26, 26, 26, 1),
              fontWeight: FontWeight.bold,
            ),
            // SMALL SCREEN TEXTS
            display3: TextStyle(
              fontSize: 15,
              color: Color.fromRGBO(26, 26, 26, 1.0),
              fontWeight: FontWeight.normal,
            ),
            body1: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            // WORKOUT NAME
            body2: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.7,
              color: Color.fromRGBO(26, 26, 26, 1),
            ),
          ),
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          TrainerWorkoutsScreen.routeName: (context) => TrainerWorkoutsScreen(),
          WorkoutOverviewScreen.routeName: (context) => WorkoutOverviewScreen(),
          WorkoutScreen.routeName: (context) => WorkoutScreen(),
          ExerciseOverviewScreen.routeName: (context) => ExerciseOverviewScreen(),
          TrainerInfoScreen.routeName: (context) => TrainerInfoScreen(),
        },
      ),
    );
  }
}
