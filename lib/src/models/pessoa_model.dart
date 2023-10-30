class Pessoa {
  String? pessoaId;
  String? nome;
  String? cpf;
  String? dataNascimento;
  String? email;
  String? contato;
  String? tipoSanguineo;
  bool? alergia;
  String? tipoAlergia;
  bool? doador;
  bool? tipoResponsavel;
  String? cartaoNacional;
  String? cartaoPlanoSaude;

  Pessoa({
    required this.pessoaId,
    required this.nome,
    required this.cpf,
    required this.dataNascimento,
    this.email,
    this.contato,
    this.tipoSanguineo,
    this.alergia,
    this.tipoAlergia,
    this.doador,
    this.tipoResponsavel,
    this.cartaoNacional,
    this.cartaoPlanoSaude,
  });


  Pessoa copyWith({
    String? pessoaId,
    String? nome,
    String? cpf,
    String? email,
    String? contato,
    String? dataNascimento,
    String? tipoSanguineo,
    bool? alergia,
    bool? doador,
    String? tipoAlergia,
    bool? tipoResponsavel,
    String? cartaoNacional,
    String? cartaoPlanoSaude,
  }) {
    return Pessoa(
      pessoaId: pessoaId ?? this.pessoaId,
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      contato: contato ?? this.contato,
      email: email ?? this.email,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      tipoSanguineo: tipoSanguineo ?? this.tipoSanguineo,
      alergia: alergia ?? this.alergia,
      doador: doador ?? this.doador,
      tipoAlergia: tipoAlergia ?? this.tipoAlergia,
      tipoResponsavel: tipoResponsavel ?? this.tipoResponsavel,
      cartaoNacional: cartaoNacional ?? this.cartaoNacional,
      cartaoPlanoSaude: cartaoPlanoSaude ?? this.cartaoPlanoSaude,
    );
  }

  factory Pessoa.fromJson(Map<String, dynamic> json) {
    return Pessoa(
      pessoaId: json['pessoaId'],
      nome: json['nome'],
      cpf: json['cpf'],
      email: json['email'],
      contato: json['contato'],
      dataNascimento: json['dataNascimento'],
      tipoSanguineo: json['tipoSanguineo'],
      alergia: json['alergia'],
      doador: json['doador'],
      tipoAlergia: json['tipoAlergia'],
      tipoResponsavel: json['tipoResponsavel'],
      cartaoNacional: json['cartaoNacional'],
      cartaoPlanoSaude: json['cartaoPlanoSaude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pessoa_id': pessoaId,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'contato': contato,
      'dataNascimento': dataNascimento,
      'tipoSanguineo': tipoSanguineo,
      'alergia': alergia,
      'doador': doador,
      'tipoAlergia': tipoAlergia,
      'tipoResponsavel': tipoResponsavel,
      'cartaoNacional': cartaoNacional,
      'cartaoPlanoSaude': cartaoPlanoSaude,
    };
  }
}
