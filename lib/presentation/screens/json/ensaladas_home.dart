import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tarea_login/presentation/screens/json/ensalada.dart';

class EnsaladasHome extends StatefulWidget {
  const EnsaladasHome({super.key});

  @override
  State<EnsaladasHome> createState() => _EnsaladasHomeState();
}

class _EnsaladasHomeState extends State<EnsaladasHome> {
  late Future<List<Ensalada>> _ensaladas;

  Future<List<Ensalada>> cargarEnsaladas() async {
    final String response = await DefaultAssetBundle.of(context)
        .loadString('assets/json/ensaladas.json');
    final data = json.decode(response) as List;
    return data.map((json) => Ensalada.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    _ensaladas = cargarEnsaladas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú de Ensaladas'),
      ),
      body: FutureBuilder<List<Ensalada>>(
        future: _ensaladas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar las ensaladas'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay ensaladas disponibles'));
          }

          final ensaladas = snapshot.data!;

          return ListView.builder(
            itemCount: ensaladas.length,
            itemBuilder: (context, index) {
              final ensalada = ensaladas[index];
              return _cardEnsalada(ensalada);
            },
          );
        },
      ),
    );
  }

  Card _cardEnsalada(Ensalada ensalada) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(ensalada.imagen),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ensalada.nombre,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Ingredientes: ${ensalada.ingredientes}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Valor Nutricional: ${ensalada.valorNutricional}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  ensalada.descripcion,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
