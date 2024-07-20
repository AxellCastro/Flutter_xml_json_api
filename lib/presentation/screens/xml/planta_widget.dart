import 'package:flutter/material.dart';
import 'package:tarea_login/presentation/screens/xml/planta.dart';

class PlantaWidget extends StatelessWidget {
  final List<Planta> plantas;

  const PlantaWidget({super.key, required this.plantas});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 8.0),
          child: Text(
            'Plantas',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: plantas.length,
            itemBuilder: (context, index) {
              final planta = plantas[index];
              return Container(
                width: 160,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(planta.url,
                        fit: BoxFit.cover, height: 120, width: 160),
                    Text(
                      planta.nombre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Text(planta.familia),
                    Text(
                      planta.descripcion,
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
