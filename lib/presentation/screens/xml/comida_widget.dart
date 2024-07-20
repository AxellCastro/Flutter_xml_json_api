import 'package:flutter/material.dart';
import 'package:tarea_login/presentation/screens/xml/comida.dart';

class ComidaWidget extends StatelessWidget {
  final List<Comida> comidas;

  const ComidaWidget({super.key, required this.comidas});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 8.0),
          child: Text(
            'Comidas',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: comidas.length,
            itemBuilder: (context, index) {
              final comida = comidas[index];
              return Container(
                width: 160,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(comida.url,
                        fit: BoxFit.cover, height: 120, width: 160),
                    Text(
                      comida.nombre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Text(
                      comida.ingredientes,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
