import 'package:chatrealtime/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chatrealtime/routes/routes.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App Jacrek',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}