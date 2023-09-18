class Agendamento {
  final String tipoAgendamento;
  final String especialista;
  final String descricao;
  final String local;
  final DateTime dataHora;
  final String observacoes;
  final bool realizado;

  Agendamento({
    required this.tipoAgendamento,
    required this.especialista,
    required this.descricao,
    required this.local,
    required this.dataHora,
    required this.observacoes,
    required this.realizado,
  });
}
