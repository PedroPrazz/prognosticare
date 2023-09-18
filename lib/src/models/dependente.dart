class Dependente {
  String dependenteId;
  String nome;
  String cpf;
  String dataNascimento;
  String? tipoSanguineo;
  bool? alergia;
  String? tipoAlergia;
  bool? doador;
  String? cartaoNacional;
  String? cartaoPlanoSaude;

  Dependente({
    required this.dependenteId,
    required this.nome,
    required this.cpf,
    required this.dataNascimento,
    required this.tipoSanguineo,
    required this.alergia,
    required this.doador,
    required this.tipoAlergia,
    required this.cartaoNacional,
    required this.cartaoPlanoSaude,
  });

  Dependente copyWith({
    String? dependenteId,
    String? nome,
    String? cpf,
    String? dataNascimento,
    String? tipoSanguineo,
    bool? alergia,
    bool? doador,
    String? tipoAlergia,
    String? cartaoNacional,
    String? cartaoPlanoSaude,
  }) {
    return Dependente(
      dependenteId: dependenteId ?? this.dependenteId,
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      tipoSanguineo: tipoSanguineo ?? this.tipoSanguineo,
      alergia: alergia ?? this.alergia,
      doador: doador ?? this.doador,
      tipoAlergia: tipoAlergia ?? this.tipoAlergia,
      cartaoNacional: cartaoNacional ?? this.cartaoNacional,
      cartaoPlanoSaude: cartaoPlanoSaude ?? this.cartaoPlanoSaude,
    );
  }

  factory Dependente.fromJson(Map<String, dynamic> json) {
    return Dependente(
      dependenteId: json['pessoa_id'],
      nome: json['nome'],
      cpf: json['cpf'],
      dataNascimento: json['dataNascimento'],
      tipoSanguineo: json['tipoSanguineo'],
      alergia: json['alergia'],
      doador: json['doador'],
      tipoAlergia: json['tipoAlergia'],
      cartaoNacional: json['cartaoNacional'],
      cartaoPlanoSaude: json['cartaoPlanoSaude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pessoa_id': dependenteId,
      'nome': nome,
      'cpf': cpf,
      'dataNascimento': dataNascimento,
      'tipoSanguineo': tipoSanguineo,
      'alergia': alergia,
      'doador': doador,
      'tipoAlergia': tipoAlergia,
      'cartaoNacional': cartaoNacional,
      'cartaoPlanoSaude': cartaoPlanoSaude,
    };
  }
}
