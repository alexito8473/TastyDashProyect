import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tfgsaladillo/model/Comida.dart';

class Carta extends StatefulWidget {
  final List<Comida> listaDeComida;
  const Carta({super.key, required this.listaDeComida});
  @override
  State<Carta> createState() => _Carta();
}

class _Carta extends State<Carta> {
  late String imagenActual;
  @override
  void initState() {
    imagenActual = widget.listaDeComida[0].foto;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Column(
          children: [
            ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.white
                        ]).createShader(bounds),
                blendMode: BlendMode.colorDodge,
                child: Container(
                    padding: EdgeInsets.only(top: size.height*0.15, bottom: size.height*0.05),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(imagenActual),
                            fit: BoxFit.cover)),
                    child: CarouselSlider(
                      options: CarouselOptions(
                          pageSnapping: true,
                          height: size.height * 0.35,
                          initialPage: 0,
                          aspectRatio: 16 / 9,
                          disableCenter: false,
                          viewportFraction: 0.7,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 8),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.easeInCubic,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) => setState(() {
                                imagenActual = widget.listaDeComida[index].foto;
                              }),
                          scrollDirection: Axis.horizontal),
                      items: widget.listaDeComida.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return ComidaViewCarrusel(comida: i);
                          },
                        );
                      }).toList(),
                    ))),
            SizedBox(
              height: size.height*0.35,
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton.large(
                      onPressed: () => {},
                      backgroundColor: Colors.orange.shade300,
                     tooltip: "Hola",
                      child: SvgPicture.asset(
                          "assets/Icons/Burguer.svg",width: 60,
                      ),
                    ),
                    FloatingActionButton.large(
                      onPressed: () => {},
                      backgroundColor: Colors.green.shade300,
                      tooltip: "Hola",
                      child: SvgPicture.asset(
                        "assets/Icons/Salad.svg",width: 60,
                      ),
                    ),
                    FloatingActionButton.large(
                      onPressed: () => {},
                      backgroundColor: Colors.blue.shade300,
                      tooltip: "Hola",
                      child: SvgPicture.asset(
                        "assets/Icons/Fish.svg",width: 60,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton.large(
                      onPressed: () => {},
                      backgroundColor: Colors.lime.shade300,
                      tooltip: "Hola",
                      child: SvgPicture.asset(
                        "assets/Icons/Meat.svg",width: 60,
                      ),
                    ),
                    FloatingActionButton.large(
                      onPressed: () => {},
                      backgroundColor: Colors.red,
                      tooltip: "Hola",
                      child: SvgPicture.asset(
                        "assets/Icons/Drink.svg",width: 60,
                      ),
                    ),
                    FloatingActionButton.large(
                      onPressed: () => {},
                      backgroundColor: Colors.yellow.shade300,
                      tooltip: "Hola",
                      child: SvgPicture.asset(
                        "assets/Icons/Menu.svg",width: 60,
                      ),
                    )
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
