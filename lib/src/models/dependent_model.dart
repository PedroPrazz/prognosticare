class Dependente {
  String? pessoaId;
  String nome;
  String cpf;
  String dataNascimento;
  String? tipoSanguineo;
  bool? alergia;
  bool? ativo;
  String? tipoAlergia;
  String? cartaoNacional;
  String? cartaoPlanoSaude;

  Dependente({
    required this.ativo,
    required this.pessoaId,
    required this.nome,
    required this.cpf,
    required this.dataNascimento,
    required this.tipoSanguineo,
    required this.alergia,
    required this.tipoAlergia,
    required this.cartaoNacional,
    required this.cartaoPlanoSaude,
  });

  Dependente.cadastrar({
    required this.nome,
    required this.cpf,
    required this.dataNascimento,
    required this.tipoSanguineo,
    required this.alergia,
    required this.tipoAlergia,
    required this.cartaoNacional,
    required this.cartaoPlanoSaude,
  });

  Dependente.editar({
    required this.pessoaId,
    required this.ativo,
    required this.nome,
    required this.cpf,
    required this.dataNascimento,
    required this.tipoSanguineo,
    required this.alergia,
    required this.tipoAlergia,
    required this.cartaoNacional,
    required this.cartaoPlanoSaude,
  });

  factory Dependente.fromJson(Map<String, dynamic> json) {
    return Dependente(
      ativo: json['ativo'],
      pessoaId: json['pessoaId'],
      nome: json['nome'],
      cpf: json['cpf'],
      dataNascimento: json['dataNascimento'],
      tipoSanguineo: json['tipoSanguineo'],
      alergia: json['alergia'],
      tipoAlergia: json['tipoAlergia'],
      cartaoNacional: json['cartaoNacional'],
      cartaoPlanoSaude: json['cartaoPlanoSaude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ativo': ativo,
      'pessoaId': pessoaId,
      'nome': nome,
      'cpf': cpf,
      'dataNascimento': dataNascimento,
      'tipoSanguineo': tipoSanguineo,
      'alergia': alergia,
      'tipoAlergia': tipoAlergia,
      'cartaoNacional': cartaoNacional,
      'cartaoPlanoSaude': cartaoPlanoSaude,
    };
  }
}
