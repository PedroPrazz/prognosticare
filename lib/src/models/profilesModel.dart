class Profile {
  String? pessoaId;
  String? nome;
  bool? ativo;
  bool? tipoResponsavel;
 

  Profile({
    required this.pessoaId,
    required this.nome,
    required this.ativo,
    required this.tipoResponsavel,
    
  });

  Profile copyWith({
    String? pessoaId,
    String? nome,
    bool? ativo,
    bool? tipoResponsavel,
  }) {
    return Profile(
      pessoaId: pessoaId ?? this.pessoaId,
      nome: nome ?? this.nome,
      ativo: ativo ?? this.ativo,
      tipoResponsavel: tipoResponsavel ?? this.tipoResponsavel,
      
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      pessoaId: json['pessoaId'],
      nome: json['nome'],
      ativo: json['ativo'],
      tipoResponsavel: json['tipoResponsavel'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pessoaId': pessoaId,
      'nome': nome,
      'ativo': ativo,
      'tipoResponsavel': tipoResponsavel,
      
    };
  }


}
