import 'package:tarea_login/presentation/screens/xml/comida.dart';
import 'package:tarea_login/presentation/screens/xml/planta.dart';
import 'package:tarea_login/presentation/screens/xml/receta.dart';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/services.dart'; // Para cargar los archivos

Future<List<Comida>> leerComidas() async {
  final data = await rootBundle.loadString('assets/xml/comida.xml');
  final document = xml.XmlDocument.parse(data);
  final elementos = document.findAllElements('plato');

  return elementos.map((elemento) {
    final nombre = elemento.findElements('nombre').single.text;
    final ingredientes = elemento.findElements('ingredientes').single.text;
    final preparacion = elemento.findElements('preparacion').single.text;
    final url = elemento.findElements('url').single.text;
    return Comida(
        nombre: nombre,
        ingredientes: ingredientes,
        preparacion: preparacion,
        url: url);
  }).toList();
}

Future<List<Planta>> leerPlantas() async {
  final data = await rootBundle.loadString('assets/xml/plantas.xml');
  final document = xml.XmlDocument.parse(data);
  final elementos = document.findAllElements('planta');

  return elementos.map((elemento) {
    final nombre = elemento.findElements('nombre').single.text;
    final familia = elemento.findElements('familia').single.text;
    final descripcion = elemento.findElements('descripcion').single.text;
    final url = elemento.findElements('url').single.text;
    return Planta(
        nombre: nombre, familia: familia, descripcion: descripcion, url: url);
  }).toList();
}

Future<List<Receta>> leerRecetas() async {
  final data = await rootBundle.loadString('assets/xml/recetas.xml');
  final document = xml.XmlDocument.parse(data);
  final elementos = document.findAllElements('receta');

  return elementos.map((elemento) {
    final nombre = elemento.findElements('nombre').single.text;
    final ingredientes = elemento.findElements('ingredientes').single.text;
    final preparacion = elemento.findElements('preparacion').single.text;
    final url = elemento.findElements('url').single.text;
    return Receta(
        nombre: nombre,
        ingredientes: ingredientes,
        preparacion: preparacion,
        url: url);
  }).toList();
}
