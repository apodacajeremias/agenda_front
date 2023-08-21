class Colaborador {
  String? id;
  bool? activo;
  String? nombre;
  DateTime? fechaCreacion;
  DateTime? fechaModificacion;
  String? registroContribuyente;
  String? registroProfesional;
  String? profesion;

  Colaborador({
    this.id,
    this.activo,
    this.nombre,
    this.fechaCreacion,
    this.fechaModificacion,
    this.registroContribuyente,
    this.registroProfesional,
    this.profesion,
  });

  factory Colaborador.fromJson(Map<String, dynamic> json) => Colaborador(
        id: json['id'],
        activo: json['activo'],
        nombre: json['nombre'],
        registroContribuyente: json['registroContribuyente'],
        registroProfesional: json['registroProfesional'],
        profesion: json['profesion'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'activo': activo,
        'registroContribuyente': registroContribuyente,
        'registroProfesional': registroProfesional,
        'profesion': profesion,
      };

  @override
  String toString() {
    return nombre ?? 'N/A';
  }
}
