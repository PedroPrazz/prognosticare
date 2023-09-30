class Schedule {
  String? id;
  String? dataAgenda;
  String? local;
  String? statusEvento;
  String descricao;
  int? intervaloData;
  String? observacao;
  String? especialista;
  String? tipoAgendamento;

  Schedule({
    required this.id,
    required this.dataAgenda,
    required this.local,
    required this.statusEvento,
    required this.descricao,
    required this.intervaloData,
    required this.observacao,
    required this.especialista,
    required this.tipoAgendamento,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      dataAgenda: json['dataAgenda'],
      local: json['local'],
      statusEvento: json['statusEvento'],
      descricao: json['descricao'],
      intervaloData: json['intervaloData'],
      observacao: json['observacao'],
      especialista: json['especialista'],
      tipoAgendamento: json['tipoExame'],
    );
  }

  // Schedule copyWith({
  //   String? id,
  //   String? dataAgenda,
  //   String? local,
  //   String? statusEvento,
  //   String? descricao,
  //   int? intervaloData,
  //   String? observacao,
  //   String? especialista,
  //   String? tipoAgendamento,
  // }) {
  //   return Schedule(
  //   id: id ?? this.id,
  //   dataAgenda: dataAgenda ?? this.dataAgenda,
  //   local: local ?? this.local,
  //   statusEvento: statusEvento ?? this.statusEvento,
  //   descricao: descricao ?? this.descricao,
  //   intervaloData: intervaloData ?? this.intervaloData,
  //   observacao: observacao ?? this.observacao,
  //   especialista: especialista ?? this.especialista,
  //   tipoAgendamento: tipoAgendamento ?? this.tipoAgendamento,
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dataAgenda': dataAgenda,
      'local': local,
      'statusEvento': statusEvento,
      'descricao': descricao,
      'intervaloData': intervaloData,
      'observacao': observacao,
      'especialista': especialista,
      'tipoExame': tipoAgendamento,
    };
  }
}
