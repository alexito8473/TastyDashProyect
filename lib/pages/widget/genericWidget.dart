import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: size.width * 0.14,
          width: size.width * 0.14,
          margin: EdgeInsets.only(
              right: size.height * 0.01, bottom: size.height * 0.01),
          decoration: const BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child: const Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
          ),
        ));
  }
}

class Background extends StatelessWidget {
  final String asset;

  const Background({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.centerRight,
            colors: [Colors.black87, Colors.transparent]).createShader(bounds),
        blendMode: BlendMode.darken,
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(asset),
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                        Colors.black38, BlendMode.darken)))));
  }
}

class TextFieldMio extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final Size sizeContext;
  final IconData icono;
  final TextInputType textType;
  final TextInputAction action;
  final bool obscureText;

  const TextFieldMio(
      {super.key,
      required this.hint,
      required this.controller,
      required this.sizeContext,
      required this.icono,
      required this.textType,
      required this.action,
      required this.obscureText});

  @override
  State<StatefulWidget> createState() => _TextFielMio();
}

class _TextFielMio extends State<TextFieldMio> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.sizeContext.height * 0.01),
      child: Container(
        alignment: Alignment.center,
        height: widget.sizeContext.height * 0.06,
        width: widget.sizeContext.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white60, borderRadius: BorderRadius.circular(24)),
        child: TextFormField(
          controller: widget.controller,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  widget.icono,
                  size: 30,
                  color: Colors.black,
                )),
            border: InputBorder.none,
            hintStyle: const TextStyle(fontWeight: FontWeight.bold),
            hintText: widget.hint,
          ),
          obscureText: widget.obscureText,
          keyboardType: widget.textType,
          textInputAction: widget.action,
        ),
      ),
    );
  }
}

void messageToCustomer(BuildContext context, String mensage, double font) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 1,
    width: 300.0,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: Colors.white70,
    duration: const Duration(milliseconds: 1100),
    content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Text(
          mensage,
          style: TextStyle(
              fontSize: font, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        )),
  ));
}