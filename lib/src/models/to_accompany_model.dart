class Accompany {
  String? id;
  String? tipoAcompanhamento;
  String? medicacao;
  String? statusEvento;
  String? dataAcompanhamento;
  int? intervaloHora;
  String? tipoTemporarioControlado;
  String? prescricaoMedica;

  Accompany({
    required this.id,
    required this.tipoAcompanhamento,
    required this.medicacao,
    required this.statusEvento,
    required this.dataAcompanhamento,
    required this.intervaloHora,
    required this.tipoTemporarioControlado,
    required this.prescricaoMedica,
  });

  factory Accompany.fromJson(Map<String, dynamic> json) {
    return Accompany(
      id: json['id'],
      tipoAcompanhamento: json['tipoAcompanhamento'],
      medicacao: json['medicacao'],
      statusEvento: json['statusEvento'],
      dataAcompanhamento: json['dataAcompanhamento'],
      intervaloHora: json['intervaloHora'],
      tipoTemporarioControlado: json['tipoTemporarioControlado'],
      prescricaoMedica: json['prescricaoMedica'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicacao': medicacao,
      'dataAcompanhamento': dataAcompanhamento,
      'intervaloHora': intervaloHora,
      'prescricaoMedica': prescricaoMedica,
      'statusEvento': statusEvento,
      'tipoTemporarioControlado': tipoTemporarioControlado,
      'tipoAcompanhamento': tipoAcompanhamento,
    };
}
}
