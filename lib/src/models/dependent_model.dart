class Dependente {
  String nome;
  String cpf;
  String dataNascimento;
  String? tipoSanguineo;
  bool? alergia;
  String? tipoAlergia;
  String? cartaoNacional;
  String? cartaoPlanoSaude;

  Dependente ({
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
