
import 'package:chatrealtime/services/auth_service.dart';
import 'package:chatrealtime/widgets/boton_azul.dart';
import 'package:flutter/material.dart';


import 'package:chatrealtime/widgets/custom_input.dart';
import 'package:chatrealtime/widgets/labels.dart';
import 'package:chatrealtime/widgets/logo.dart';
import 'package:provider/provider.dart';
import 'package:chatrealtime/helpers/mostrar_alerta.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(titulo: 'Messenger',),
                _Form(),
                Labels(ruta:'register',
                  titulo: 'No tienes cuenta?',
                  subTitulo: 'Crea una ahora!',),

                Text('Términos y Condiciones de uso',style: TextStyle(fontWeight: FontWeight.w200),),




              ],
            ),
          ),
        ),
      ),
    );
  }
}



class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(

      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[

          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'correo',
            textController: emailCtrl,

          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            keyboardType: TextInputType.emailAddress,
            textController: passCtrl,
            isPassword: true,
          ),

          BotonAzul(
            text: 'Ingrese',
            onPressed: authService.autenticando ? null :  () async{
            //  print(emailCtrl.text);
            //  print(passCtrl.text);
              FocusScope.of(context).unfocus();

              final loginOK = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());

              if (loginOK) {
                //TODO: Conectar a nuestro socket server
                Navigator.pushReplacementNamed(context, 'usuarios');

              }else{
                mostrarAlerta(context, 'Login incorrecto', 'Revise sus credenciales nuevamente');

              }

              //authService.au
              },
          ),


        ],
      ),
    );
  }
}