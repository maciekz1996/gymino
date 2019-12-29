import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import './login_screen.dart';
import '../home_screen.dart';

class AuthWrapper extends StatelessWidget {
  static const String routeName = '/auth-wrapper';
  
  @override
  Widget build(BuildContext context) {        
    final user = Provider.of<User>(context);
        
    if (user == null){
      return LoginScreen();
    } else {
      return HomeScreen();
    }
    
  }
}