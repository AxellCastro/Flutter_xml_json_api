class Ensalada {
  final String nombre;
  final String ingredientes;
  final String valorNutricional;
  final String descripcion;
  final String imagen;

  Ensalada({
    required this.nombre,
    required this.ingredientes,
    required this.valorNutricional,
    required this.descripcion,
    required this.imagen,
  });

  factory Ensalada.fromJson(Map<String, dynamic> json) {
    return Ensalada(
      nombre: json['nombre'],
      ingredientes: json['ingredientes'],
      valorNutricional: json['valorNutricional'],
      descripcion: json['descripcion'],
      imagen: json['imagen'],
    );
  }
}

