// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tfgsaladillo/Recursos.dart';
import 'package:tfgsaladillo/model/Comida.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Moneda.dart';
import 'package:tfgsaladillo/pages/ListComida.dart';

class Carta extends StatefulWidget {
  final List<Comida> listaDeComida;
  final Idioma idioma;
  Moneda monedaEnUso;
  Carta(
      {super.key,
      required this.listaDeComida,
      required this.idioma,
      required this.monedaEnUso});
  @override
  State<Carta> createState() => _Carta();
}

class _Carta extends State<Carta> {
  late String imagenActual;
  @override
  void initState() {
    imagenActual = widget.listaDeComida[0].foto;
    super.initState();
  }

  void NavegarLista(List<Comida> listaDeUnaComida, String imagenBanner,String nombreLista) {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      barrierColor: Colors.black54,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ListaComida(
            listaComida: listaDeUnaComida,
            imagenBanner: imagenBanner,
            monedEnUso: widget.monedaEnUso,
            idioma: widget.idioma, nombreLista: nombreLista,
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: Container(
            width: size.width,
            height: size.height,
            color: Colors.black,
            child: SingleChildScrollView(
                child: Column(children: [
              ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          stops: [
                            0.2,
                            0.6,
                            1
                          ],
                          colors: [
                            Colors.transparent,
                            Colors.black26,
                            Colors.black
                          ]).createShader(bounds),
                  blendMode: BlendMode.darken,
                  child: Container(
                      width: size.width,
                      height: size.height * 0.55,
                      padding: EdgeInsets.only(
                          top: size.height * 0.15, bottom: size.height * 0.05),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                            image: AssetImage(imagenActual),
                            fit: BoxFit.cover,
                          )),
                      child: CarouselSlider(
                        options: CarouselOptions(
                            pageSnapping: true,
                            enlargeFactor: 0.35,
                            height: size.height * 0.35,
                            initialPage: 0,
                            disableCenter: false,
                            viewportFraction: 0.65,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 8),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.easeInCubic,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) => setState(() {
                                  imagenActual =
                                      widget.listaDeComida[index].foto;
                                }),
                            scrollDirection: Axis.horizontal),
                        items: widget.listaDeComida.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ComidaViewCarrusel(
                                comida: i,
                                monedaEnUso: widget.monedaEnUso,
                                idioma: widget.idioma,
                              );
                            },
                          );
                        }).toList(),
                      ))),
              Container(
                  width: size.width,
                  height: size.height * 0.374,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          image: const AssetImage(
                              "assets/images/bannerFiltros.webp"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.7),
                              BlendMode.darken))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FloatingActionButton.large(
                              heroTag: null,
                              onPressed: () => {
                                // Hamburguesa
                                NavegarLista(
                                    widget.listaDeComida
                                        .where((element) => element.isBurguer)
                                        .toList(),
                                    "assets/images/hamburguesasBanner.webp",widget.idioma
                                    .datosJson[widget.idioma.positionIdioma]
                                ["HoverHambur"]
                                )
                              },
                              backgroundColor: Colors.orange.shade300,
                              tooltip: widget.idioma
                                      .datosJson[widget.idioma.positionIdioma]
                                  ["HoverHambur"],
                              child: SvgPicture.asset(
                                "assets/Icons/Burguer.svg",
                                width: 60,
                              ),
                            ),
                            FloatingActionButton.large(
                              heroTag: null,
                              onPressed: () => {
                                // Ensalada
                                NavegarLista(
                                    widget.listaDeComida
                                        .where((element) => element.isEnsalada)
                                        .toList(),
                                    "assets/images/ensaladaBanner.webp",widget.idioma
                                    .datosJson[widget.idioma.positionIdioma]
                                ["HoverEnsa"])
                              },
                              backgroundColor: Colors.green.shade300,
                              tooltip: widget.idioma
                                      .datosJson[widget.idioma.positionIdioma]
                                  ["HoverEnsa"],
                              child: SvgPicture.asset(
                                "assets/Icons/Salad.svg",
                                width: 60,
                              ),
                            ),
                            FloatingActionButton.large(
                              heroTag: null,
                              onPressed: () => {
                                // Pescado
                                NavegarLista(
                                    widget.listaDeComida
                                        .where((element) => element.isPescado)
                                        .toList(),
                                    "assets/images/bannerPescado.webp", widget.idioma
                                    .datosJson[widget.idioma.positionIdioma]
                                ["HoverPesca"])
                              },
                              backgroundColor: Colors.blue.shade300,
                              tooltip: widget.idioma
                                      .datosJson[widget.idioma.positionIdioma]
                                  ["HoverPesca"],
                              child: SvgPicture.asset(
                                "assets/Icons/Fish.svg",
                                width: 60,
                              ),
                            )
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FloatingActionButton.large(
                                heroTag: null,
                                onPressed: () => {
                                  // Carne
                                  NavegarLista(
                                      widget.listaDeComida
                                          .where((element) => element.isCarne)
                                          .toList(),
                                      "assets/images/bannerCarne.webp",widget.idioma
                                      .datosJson[widget.idioma.positionIdioma]
                                  ["HoverCarne"])
                                },
                                backgroundColor: Colors.lime.shade300,
                                tooltip: widget.idioma
                                        .datosJson[widget.idioma.positionIdioma]
                                    ["HoverCarne"],
                                child: SvgPicture.asset(
                                  "assets/Icons/Meat.svg",
                                  width: 60,
                                ),
                              ),
                              FloatingActionButton.large(
                                heroTag: null,
                                onPressed: () => {
                                  // Filtramos solo por bebida
                                  NavegarLista(
                                      widget.listaDeComida
                                          .where((element) => element.isBebida)
                                          .toList(),
                                      "assets/images/bannerBebida.webp",widget.idioma
                                      .datosJson[widget.idioma.positionIdioma]
                                  ["HoverBebida"])
                                },
                                backgroundColor: Colors.red,
                                tooltip: widget.idioma
                                        .datosJson[widget.idioma.positionIdioma]
                                    ["HoverBebida"],
                                child: SvgPicture.asset(
                                  "assets/Icons/Drink.svg",
                                  width: 60,
                                ),
                              ),
                              FloatingActionButton.large(
                                  heroTag: null,
                                  onPressed: () => {
                                        // Filtramos solo por
                                    NavegarLista(
                                        widget.listaDeComida,
                                        "assets/images/bannerBebida.webp","Prueba")
                                      },
                                  backgroundColor: Colors.yellow.shade300,
                                  tooltip: widget.idioma.datosJson[widget
                                      .idioma.positionIdioma]["HoverCarta"],
                                  child: SvgPicture.asset(
                                    "assets/Icons/Menu.svg",
                                    width: 60,
                                  ))
                            ])
                      ]))
            ]))));
  }
}
