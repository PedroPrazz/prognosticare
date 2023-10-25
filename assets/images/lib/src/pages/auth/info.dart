import 'package:flutter/material.dart';
import 'package:prognosticare/src/config/custom_colors.dart';
import 'package:prognosticare/src/pages/home/home_screen.dart';

class InfoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre o App'),
        centerTitle: true,
        backgroundColor: CustomColors.customSwatchColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false);
            },
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Text(
              'No mundo agitado de hoje, cuidar da nossa saúde é mais importante do que nunca. O Prognosticare surge como uma solução inovadora e essencial para usuários que desejam ter um papel mais ativo sobre seu prontuário e o controle de seu próprio bem-estar. Este sistema de gerenciamento de prognóstico de saúde capacita os usuários a gerenciar seus prontuários médicos de forma eficiente, garantindo que tenham acesso fácil e rápido às informações de saúde mais importantes.\n\nAlguns detalhes:\n\nGestão de Prontuário Online: Prognosticare permite que os usuários criem e atualizem seus próprios prontuários médicos de forma digital. Isso elimina a necessidade de manter registros em papel, tornando as informações mais organizadas e acessíveis.\nAcesso a Qualquer Hora e Lugar: Com a Prognosticare, os dados de saúde estão ao alcance 24 horas por dia, 7 dias por semana, através de dispositivos móveis.\nSegurança de Dados: A segurança dos dados é uma prioridade máxima. Prognosticare está em conformidade com as leis de proteção de dados (LGPD) e privacidade do paciente para garantir que suas informações de saúde estejam protegidas contra acesso não autorizado.\nRegistro de Consultas e Medicamentos: Os usuários podem registrar todas as consultas médicas, procedimentos, exames e medicamentos em um só lugar. Onde auxiliar a terem um histórico abrangente de saúde, facilitando a comunicação com profissionais de saúde.\nLembretes e Alertas: Prognosticare envia lembretes de consultas médicas, exames de rotina e a hora certa para tomar medicamentos. Isso ajuda os usuários a manterem-se em dia com seu plano de tratamento.\n\nBenefícios para os Usuários:\n\nAutonomia na Saúde: O Prognosticare capacita os usuários a tomar decisões informadas sobre sua saúde e bem-estar.\nEficiência: A gestão digital de prontuários economiza tempo e reduz erros associados à documentação manual.\nMonitoramento Constante: Lembretes e alertas garantem que os usuários estejam em conformidade com seus planos de saúde.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
