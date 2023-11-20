// import 'package:flutter/material.dart';

// class InfoApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sobre o App'),
//         centerTitle: true,
//         foregroundColor: Colors.white,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Sua logo
//           Container(
//             padding: EdgeInsets.all(10),
//             child: Image.asset(
//               'assets/images/logo.png',
//               width: 350,
//               height: 300,
//             ),
//           ),
//           // Card 1
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => NovaTela()),
//               );
//             },
//             child: Card(
//               margin: EdgeInsets.all(16),
//               child: ListTile(
//                 title: Text('Card 1'),
//                 subtitle: Text('Clique para ir para outra tela'),
//               ),
//             ),
//           ),
//           // Card 2
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => NovaTela()),
//               );
//             },
//             child: Card(
//               margin: EdgeInsets.all(16),
//               child: ListTile(
//                 title: Text('Card 2'),
//                 subtitle: Text('Clique para ir para outra tela'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class NovaTela extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Nova Tela'),
//       ),
//       body: Center(
//         child: Text('Conteúdo da nova tela'),
//       ),
//     );
//   }
// }
