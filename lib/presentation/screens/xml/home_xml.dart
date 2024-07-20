import 'package:flutter/material.dart';
import 'package:tarea_login/presentation/screens/xml/comida.dart';
import 'package:tarea_login/presentation/screens/xml/comida_widget.dart';
import 'package:tarea_login/presentation/screens/xml/planta.dart';
import 'package:tarea_login/presentation/screens/xml/planta_widget.dart';
import 'package:tarea_login/presentation/screens/xml/receta.dart';
import 'package:tarea_login/presentation/screens/xml/receta_widget.dart';
import 'package:tarea_login/presentation/screens/xml/xml_service.dart';

class HomeXml extends StatefulWidget {
  const HomeXml({super.key});

  @override
  State<HomeXml> createState() => _HomeXmlState();
}

class _HomeXmlState extends State<HomeXml> {
  late Future<List<Comida>> _comidas;
  late Future<List<Planta>> _plantas;
  late Future<List<Receta>> _recetas;

  @override
  void initState() {
    super.initState();
    _comidas = leerComidas();
    _plantas = leerPlantas();
    _recetas = leerRecetas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Datos XML')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Comida>>(
              future: _comidas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay datos disponibles'));
                } else {
                  return ComidaWidget(comidas: snapshot.data!);
                }
              },
            ),
            FutureBuilder<List<Planta>>(
              future: _plantas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay datos disponibles'));
                } else {
                  return PlantaWidget(plantas: snapshot.data!);
                }
              },
            ),
            FutureBuilder<List<Receta>>(
              future: _recetas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay datos disponibles'));
                } else {
                  return RecetaWidget(recetas: snapshot.data!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
