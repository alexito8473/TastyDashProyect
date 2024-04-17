import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfgsaladillo/Recursos.dart';
import 'package:tfgsaladillo/model/Comida.dart';
import 'package:tfgsaladillo/model/Idioma.dart';
import 'package:tfgsaladillo/model/Moneda.dart';
import 'package:tfgsaladillo/pages/MapView.dart';
import 'package:tfgsaladillo/pages/Carta.dart';
import 'package:tfgsaladillo/model/Person.dart';
import 'package:tfgsaladillo/pages/Login.dart';

class HomePage extends StatefulWidget {
  final Person person;
  final Idioma idioma;
  final BitmapDescriptor icon;
  final SharedPreferences prefs;
  final Moneda monedEnUso;
  const HomePage(
      {super.key,
      required this.person,
      required this.idioma,
      required this.prefs,
      required this.icon,
        required this.monedEnUso});
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int posicion = 0;
  // Lista de la comida
  static List<Comida> listaDeComida = CrearListaDeComida();

  // Datos para realizar el lenguaje
  late int preSelectecLenguage;
  final lenguageDropdownController = DropdownController();
  final List<String> lenguage = CrearListaPaises();
  final List<CoolDropdownItem<String>> lenguageDropdownItems = [];

  // Imagen para el mapa
  final ImageProvider imagenBannerAjustes =
      const AssetImage("assets/images/bannersuper.webp");

  // Datos para realizar la moneda
  final monedaDropdownController = DropdownController();
  final List<Moneda> monedas = Moneda.values;
  final List<CoolDropdownItem<String>> monedaDropdownItems = [];

  @override
  void initState() {
    List<String> banderas = CrearListaBanderas();
    preSelectecLenguage = widget.idioma.positionIdioma;
    for (var i = 0; i < lenguage.length; i++) {
      lenguageDropdownItems.add(
        CoolDropdownItem<String>(
            label: lenguage[i],
            icon: SizedBox(
              height: 25,
              width: 25,
              child: SvgPicture.asset(banderas[i]),
            ),
            value: '$i'),
      );
    }
    for (var i = 0; i < monedas.length; i++) {
      monedaDropdownItems.add(
        CoolDropdownItem<String>(
            label: monedas[i].name.toLowerCase().replaceFirst(
                monedas[i].name.toLowerCase().substring(0, 1),
                monedas[i].name.substring(0, 1).toUpperCase()),
            value: monedas[i].simbolo,
            icon: Text(
              monedas[i].simbolo,
              style: const TextStyle(color: Colors.black),
            )),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedSwitcher(
        switchInCurve: Curves.linear,
        duration: const Duration(milliseconds: 400),
        child: posicion == 0
            ? Carta(
                listaDeComida: listaDeComida,
                idioma: widget.idioma,
              )
            : posicion == 1
                ? Container(
                    width: size.width,
                    height: size.height,
                    color: Colors.white,
                    child: MapViewFood(icon: widget.icon),
                  )
                : Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                            image: imagenBannerAjustes, fit: BoxFit.fill)),
                    child: SingleChildScrollView(
                        child: SizedBox(
                            width: size.width,
                            child: Column(children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: size.width * 0.1,
                                    top: size.height * 0.07),
                                width: size.width,
                                child: Text(
                                  widget.idioma.datosJson[
                                      widget.idioma.positionIdioma]["MiCuenta"],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: size.width * 0.1),
                                child: Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: size.height * 0.01),
                                        width: size.width * 0.9,
                                        child: Text(
                                          widget.idioma.datosJson[widget
                                              .idioma.positionIdioma]["Nombre"],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                          textAlign: TextAlign.left,
                                        )),
                                    SizedBox(
                                        width: size.width * 0.9,
                                        child: Text(widget.person.nombre,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                            textAlign: TextAlign.left)),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: size.height * 0.01),
                                        width: size.width * 0.9,
                                        child: const Text("E-mail",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                            textAlign: TextAlign.left)),
                                    Container(
                                        margin: EdgeInsets.only(
                                            bottom: size.height * 0.02),
                                        width: size.width * 0.9,
                                        child: Text(widget.person.gmail,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                            textAlign: TextAlign.left)),
                                    FloatingActionButton.extended(
                                        backgroundColor: Colors.white,
                                        icon: const Icon(Icons.logout,
                                            color: Colors.black),
                                        onPressed: () {
                                          widget.prefs.remove("Name");
                                          widget.prefs.remove("Gmail");
                                          widget.prefs.remove("Password");
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    InicioSesion(
                                                        idioma: widget.idioma,
                                                        prefs: widget.prefs)),
                                            (route) => false,
                                          );
                                        },
                                        label: Container(
                                            width: size.width * 0.27,
                                            alignment: Alignment.center,
                                            child: Text(
                                              widget.idioma.datosJson[widget
                                                      .idioma.positionIdioma]
                                                  ["Cerrar_sesion"],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            )))
                                  ],
                                ),
                              ),
                              Container(
                                  height: size.height * 0.9,
                                  margin:
                                      EdgeInsets.only(top: size.height * 0.02),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: size.width,
                                          margin: EdgeInsets.only(
                                              top: size.height * 0.04,
                                              left: size.width * 0.1),
                                          child: Text(
                                              widget.idioma.datosJson[widget
                                                  .idioma
                                                  .positionIdioma]["Ajustes"],
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.white)),
                                        ),
                                        Container(
                                          width: size.width * 0.7,
                                          margin: EdgeInsets.only(
                                              top: size.height * 0.03,
                                              bottom: size.height * 0.02),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                child: Text(
                                                    widget.idioma.datosJson[
                                                            widget.idioma
                                                                .positionIdioma]
                                                        ["Idioma"],
                                                    style: const TextStyle(
                                                        fontSize: 20)),
                                              ),
                                              CoolDropdown<String>(
                                                controller:
                                                    lenguageDropdownController,
                                                dropdownList:
                                                    lenguageDropdownItems,
                                                defaultItem:
                                                    lenguageDropdownItems[widget
                                                        .idioma.positionIdioma],
                                                onChange: (value) => {
                                                  setState(() {
                                                    widget.idioma
                                                            .positionIdioma =
                                                        int.parse(value);
                                                    widget.prefs.setInt(
                                                        "Idioma",
                                                        int.parse(value));
                                                    print(value);
                                                  }),
                                                },
                                                resultOptions:
                                                    const ResultOptions(
                                                  width: 100,
                                                  render: ResultRender.label,
                                                  openBoxDecoration:
                                                      BoxDecoration(
                                                          color: Colors.white),
                                                  icon: SizedBox(
                                                    width: 10,
                                                    height: 10,
                                                    child: CustomPaint(
                                                      painter:
                                                          DropdownArrowPainter(
                                                        color: Colors.orange,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                dropdownOptions:
                                                    const DropdownOptions(
                                                  width: 130,
                                                ),
                                                dropdownItemOptions: styleDropdownItemOptions(),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CambioMoneda(
                                          size: size,
                                          prefs: widget.prefs,
                                          idioma: widget.idioma,
                                          monedaDropdownController:
                                              monedaDropdownController,
                                          monedaDropdownItems:
                                              monedaDropdownItems,
                                        ),
                                        BotonTerminosDeUso(
                                          idioma: widget.idioma,
                                          size: size,
                                        ),
                                      ],
                                    ),
                                  ))
                            ]))),
                  ),
      ),
      bottomNavigationBar: Container(
          color: Colors.orange,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: GNav(
            tabBackgroundColor: Colors.white70,
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.all(15),
            gap: 12,
            onTabChange: (index) {
              setState(() {
                posicion = index;
              });
            },
            tabs: [
              GButton(
                  icon: Icons.fastfood,
                  text: widget.idioma.datosJson[widget.idioma.positionIdioma]
                      ["Carta"]),
              GButton(
                  icon: Icons.map,
                  text: widget.idioma.datosJson[widget.idioma.positionIdioma]
                      ["Mapa"]),
              GButton(
                  icon: Icons.settings,
                  text: widget.idioma.datosJson[widget.idioma.positionIdioma]
                      ["Ajustes"]),
            ],
          )),
    );
  }
}

class CambioMoneda extends StatefulWidget {
  final Size size;
  final Idioma idioma;
  final SharedPreferences prefs;
  final List<CoolDropdownItem<String>> monedaDropdownItems;
  final DropdownController monedaDropdownController;
  CambioMoneda(
      {super.key,
      required this.size,
      required this.prefs,
      required this.idioma,
      required this.monedaDropdownController,
      required this.monedaDropdownItems});
  @override
  State<StatefulWidget> createState() => _CambioMoneda();
}

class _CambioMoneda extends State<CambioMoneda> {
  int preSelect = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: widget.size.width * 0.7,
      height: widget.size.height * 0.05,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            width: 105,
            child: Text("Moneda", style: TextStyle(fontSize: 20)),
          ),
          Center(
            child: CoolDropdown<String>(
              controller: widget.monedaDropdownController,
              dropdownList: widget.monedaDropdownItems,
              defaultItem: widget.monedaDropdownItems[0],
              onChange: (value) => {print},
              resultOptions: const ResultOptions(
                width: 90,
                render: ResultRender.label,
                openBoxDecoration: BoxDecoration(color: Colors.white),
                icon: SizedBox(
                  width: 10,
                  height: 10,
                  child: CustomPaint(
                    painter: DropdownArrowPainter(
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
              dropdownOptions: const DropdownOptions(
                  width: 100, align: DropdownAlign.center),
              dropdownItemOptions: styleDropdownItemOptions(),
            ),
          ),
        ],
      ),
    );
  }
}

DropdownItemOptions styleDropdownItemOptions(){
  return const DropdownItemOptions(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    textStyle: TextStyle(color: Colors.black),
    selectedTextStyle: TextStyle(color: Colors.black),
    selectedBoxDecoration: BoxDecoration(
      color: Colors.black38,
    ),
  );
}
class BotonTerminosDeUso extends StatelessWidget {
  final Idioma idioma;
  final Size size;
  const BotonTerminosDeUso({super.key, required this.idioma, required this.size});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
            barrierColor: Colors.black.withOpacity(0.6),
              useSafeArea: true,
              context: context,
              builder: (context) =>
                  AlertDialog(content: PoliticaTexto(idioma: idioma)));
        },
        child: Container(
            width: size.width * 0.7,
            height: size.height * 0.05,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: size.height * 0.02),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(idioma.datosJson[idioma.positionIdioma]["Politica"],
                style: const TextStyle(fontSize: 21, color: Colors.black))));
  }
}

class PoliticaTexto extends StatelessWidget {
  final Idioma idioma;
  const PoliticaTexto({super.key, required this.idioma});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                idioma.datosJson[idioma.positionIdioma]["Politica"],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
          Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text1"],
              style: const TextStyle(fontSize: 12)),
          Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text2"],
              style: const TextStyle(fontSize: 12)),
          Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text3"],
              style: const TextStyle(fontSize: 12)),
          Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text4"],
              style: const TextStyle(fontSize: 12)),
          Text(idioma.datosJson[idioma.positionIdioma]["Politica_Text5"],
              style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
