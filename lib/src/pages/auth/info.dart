import 'package:flutter/material.dart';
import 'package:prognosticare/src/config/custom_colors.dart';

class InfoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCard(
              'No mundo agitado de hoje, cuidar da nossa saúde é mais importante do que nunca. O Prognosticare surge como uma solução inovadora e essencial para usuários que desejam ter um papel mais ativo sobre seu prontuário e o controle de seu próprio bem-estar. Este sistema de gerenciamento de prognóstico de saúde capacita os usuários a gerenciar seus prontuários médicos de forma eficiente, garantindo que tenham acesso fácil e rápido às informações de saúde mais importantes.',
            ),
            _buildCard(
              'Alguns detalhes:\n'
              '• Gestão de Prontuário Online: Prognosticare permite que os usuários criem e atualizem seus próprios prontuários médicos de forma digital. Isso elimina a necessidade de manter registros em papel, tornando as informações mais organizadas e acessíveis.\n'
              '• Acesso a Qualquer Hora e Lugar: Com a Prognosticare, os dados de saúde estão ao alcance 24 horas por dia, 7 dias por semana, através de dispositivos móveis.\n'
              '• Registro de Consultas e Medicamentos: Os usuários podem registrar todas as consultas médicas, procedimentos, exames e medicamentos em um só lugar. Onde auxiliar a terem um histórico abrangente de saúde, facilitando a comunicação com profissionais de saúde.\n'
              '• Lembretes e Alertas: Prognosticare envia lembretes de consultas médicas, exames de rotina e a hora certa para tomar medicamentos. Isso ajuda os usuários a manterem-se em dia com seu plano de tratamento.\n',
            ),
            _buildCard(
              'Benefícios para os Usuários:\n'
              '• Autonomia na Saúde: O Prognosticare capacita os usuários a tomar decisões informadas sobre sua saúde e bem-estar.\n'
              '• Eficiência: A gestão digital de prontuários economiza tempo e reduz erros associados à documentação manual.\n'
              '• Monitoramento Constante: Lembretes e alertas garantem que os usuários estejam em conformidade com seus planos de saúde.',
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Sobre o App'),
      centerTitle: true,
      backgroundColor: CustomColors.customSwatchColor,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Container _buildCard(String content) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.fromBorderSide(BorderSide(color: Colors.grey)
      ),
      ),
      child: _buildAppInfoText(content),
    );
  }

  Text _buildAppInfoText(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 16,
        height: 1.5,
      ),
      textAlign: TextAlign.justify,
    );
  }
}
