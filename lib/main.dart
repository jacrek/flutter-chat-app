import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chatrealtime/services/auth_service.dart';
import 'package:chatrealtime/services/socket_service.dart';
import 'package:chatrealtime/services/chat_service.dart';


import 'package:chatrealtime/routes/routes.dart';

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
        ChangeNotifierProvider(create: ( _ ) => SocketService()),
        ChangeNotifierProvider(create: ( _ ) => ChatService()),
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