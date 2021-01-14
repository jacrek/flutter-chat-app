import 'package:chatrealtime/pages/login_page.dart';
import 'package:chatrealtime/pages/usuarios_page.dart';
import 'package:chatrealtime/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chatrealtime/services/auth_service.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text("Esperex..."),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {

    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);


    final autenticado = await authService.isLoggedIn();
    if(autenticado) {
      //TODO: Conectar al socket server
      //Navigator.pushReplacementNamed(context, 'usuarios');
      socketService.connect();
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_,__,___) => UsuariosPage(),
              transitionDuration: Duration(milliseconds: 0),
          )
      );
    }else{
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_,__,___) => LoginPage(),
            transitionDuration: Duration(milliseconds: 0),
          )
      );
    }

    
  }
}
