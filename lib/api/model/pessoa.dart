class Pessoa {
  String? pessoaId;
  String? nome;
  String? cpf;
  String contato;
  String? dataNascimento;
  String tipoSanguineo;
  bool alergia;
  String tipoAlergia;
  bool tipoResponsavel;
  String cartaoNacional;
  String cartaoPlanoSaude;

  Pessoa({
    required this.pessoaId,
    required this.nome,
    required this.cpf,
    required this.contato,
    required this.dataNascimento,
    required this.tipoSanguineo,
    required this.alergia,
    required this.tipoAlergia,
    required this.tipoResponsavel,
    required this.cartaoNacional,
    required this.cartaoPlanoSaude,
  });

  factory Pessoa.fromJson(Map<String, dynamic> json) {
    return Pessoa(
      pessoaId: json['pessoa_id'],
      nome: json['nome'],
      cpf: json['cpf'],
      contato: json['contato'],
      dataNascimento: json['dataNascimento'],
      tipoSanguineo: json['tipoSanguineo'],
      alergia: json['alergia'],
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
      'contato': contato,
      'dataNascimento': dataNascimento,
      'tipoSanguineo': tipoSanguineo,
      'alergia': alergia,
      'tipoAlergia': tipoAlergia,
      'tipoResponsavel': tipoResponsavel,
      'cartaoNacional': cartaoNacional,
      'cartaoPlanoSaude': cartaoPlanoSaude,
    };
  }
}
