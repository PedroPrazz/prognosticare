class Schedule {
  String? id;
  String dataAgenda;
  String local;
  String? statusEvento;
  String descricao;
  int intervaloData;
  bool? notificacao;
  String observacao;
  String especialista;
  String tipoAgendamento;

  Schedule({
    required this.id,
    required this.dataAgenda,
    required this.local,
    required this.statusEvento,
    required this.descricao,
    required this.intervaloData,
    required this.observacao,
    required this.notificacao,
    required this.especialista,
    required this.tipoAgendamento,
  });

  Schedule.editar({
    required this.id,
    required this.dataAgenda,
    required this.local,
    required this.descricao,
    required this.observacao,
    required this.notificacao,
    required this.especialista,
    required this.tipoAgendamento,
    required this.intervaloData,
    this.statusEvento
  });

  Schedule.cadastrar({
    required this.dataAgenda,
    required this.local,
    required this.descricao,
    required this.notificacao,
    required this.observacao,
    required this.especialista,
    required this.tipoAgendamento,
    required this.intervaloData,
    this.statusEvento,
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
      notificacao: json['notificacao'],
    );
  }

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
