import 'package:chatrealtime/widgets/boton_azul.dart';
import 'package:flutter/material.dart';


import 'package:chatrealtime/widgets/custom_input.dart';
import 'package:chatrealtime/widgets/labels.dart';
import 'package:chatrealtime/widgets/logo.dart';


class RegisterPage extends StatelessWidget {
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
                Logo(titulo: 'Registro',),
                _Form(),
                Labels(ruta:'login',
                titulo: 'Ya tienes cuena?',
                subTitulo: 'Ingresa ahora!',),

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

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[

          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
            isPassword: true,
          ),
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'correo',
            textController: emailCtrl,
            isPassword: true,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            keyboardType: TextInputType.emailAddress,
            textController: passCtrl,
          ),

          BotonAzul(
            text: 'Ingrese',
            onPressed: (){
              print(emailCtrl.text);
              print(passCtrl.text);
            },
          ),


        ],
      ),
    );
  }
}



