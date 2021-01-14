import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chatrealtime/services/socket_service.dart';
import 'package:chatrealtime/services/usuarios_service.dart';
import 'package:chatrealtime/services/auth_service.dart';
import 'package:chatrealtime/services/chat_service.dart';


import 'package:chatrealtime/models/usuario.dart';

class UsuariosPage extends StatefulWidget {


  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  final usuarioService = new UsuariosService();

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<Usuario> usuarios = [];

 /* final usuarios = [
    Usuario(uid: '1',nombre: 'Jacko', email: 'test1@test.com',online: true),
    Usuario(uid: '2',nombre: 'Anais', email: 'test2@test.com',online: false),
    Usuario(uid: '3',nombre: 'Jana', email: 'test3@test.com',online: true),
  ];*/

  @override
  void initState(){
    this._cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text(usuario.nombre,style: TextStyle(color: Colors.black87),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: (){
            //TODO: Desconectar el socket server
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();

          },
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (socketService.serverStatus == ServerStatus.Online)
                ?
            Icon(Icons.check_circle,color: Colors.blue[400]) :
            Icon(Icons.offline_bolt,color: Colors.red[400],) ,
            //child: Icon(Icons.offline_bolt,color: Colors.red[400],),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        child: _listViewUsuarios(),
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400],),
          waterDropColor: Colors.blue[400],
        ),
      ),
    );
  }

  ListView _listViewUsuarios(){
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuarios.length);
  }

  ListTile _usuarioListTile(Usuario usuario){
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0,2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)
        ),
      ),
      onTap:(){
        print(usuario.nombre);
        print(usuario.email);
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  _cargarUsuarios() async{

    print('pintando....');


   this.usuarios = await usuarioService.getUsuarios();
    setState(() {});

   //print(this.usuarios);

   // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
