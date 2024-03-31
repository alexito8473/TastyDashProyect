import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tfgsaladillo/Recursos.dart';
import 'package:tfgsaladillo/pages/home.dart';
import 'package:tfgsaladillo/model/Person.dart';
import 'package:tfgsaladillo/services/AuthServices.dart';
class Registrarse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Registrarse();
}

class _Registrarse extends State<Registrarse> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();
  DatabaseReference date=FirebaseDatabase.instance.ref();
  int valueNumeric=0;
  @override
  void dispose() {
    _gmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void register(BuildContext context) async {
    String nombre = _nameController.text;
    String gmail = _gmailController.text;
    String password = _passwordController.text;
    bool user = await authService.register(gmail, password);
    if (user) {
      await date.child("Person/${gmail.trim().split("@")[0].toLowerCase()}").set({
        "Nombre":nombre,
        "Gmail":gmail,
        "Password":password
      });
      await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomePage(person: Person(nombre: nombre,gmail: gmail,pasword: password),)),(route) => false,);
    } else {
      MensajeAlCliente(context,"No existe el usuario",20);
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const Background(asset: "assets/images/register.png"),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            padding: EdgeInsets.only(
                top:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? size.height*0.3
                        : 30),
            children: [
              const Titular(title: "Registrarse"),
              SizedBox(
                width: size.width * 0.8,
                child: Column(
                  children: [
                    TextFieldMio(
                      hint: "Nombre",
                      sizeContext: size,
                      textType:  TextInputType.name,
                      icono:  Icons.person,
                      controller: _nameController,
                      action: TextInputAction.next,
                      obscureText: false,
                    ),
                    TextFieldMio(
                      hint: "Gmail",
                      sizeContext: size,
                      textType:  TextInputType.emailAddress,
                      icono:  Icons.email,
                      controller: _gmailController,
                      action: TextInputAction.next,
                      obscureText: false,
                    ),
                    TextFieldMio(
                      controller: _passwordController,
                      sizeContext: size,
                      hint: "Contraseña",
                      icono:  Icons.lock,
                      textType: TextInputType.name,
                      action: TextInputAction.none,
                      obscureText: true,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20,bottom: 10),
                      height: 55,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: FloatingActionButton(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.black,
                        onPressed: () {
                          register(context);
                        },
                        child: const Text(
                          "Registrarse",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.keyboard_backspace)),
        )
      ],
    );
  }
}

