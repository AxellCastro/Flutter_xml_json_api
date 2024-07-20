import 'package:flutter/material.dart';
import 'package:tarea_login/presentation/screens/xml/receta.dart';

class RecetaWidget extends StatelessWidget {
  final List<Receta> recetas;

  const RecetaWidget({super.key, required this.recetas});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 8.0),
          child: Text(
            'Recetas',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 240, 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recetas.length,
            itemBuilder: (context, index) {
              final receta = recetas[index];
              return Container(
                width: 160,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(receta.url,
                        fit: BoxFit.cover, height: 120, width: 160),
                    Text(
                      receta.nombre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Text(
                      receta.ingredientes,
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
