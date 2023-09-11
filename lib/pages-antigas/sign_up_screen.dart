// import 'package:flutter/material.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:prognosticare/components/custom_text_field.dart';
// import 'package:prognosticare/src/auth/sign_in_screen.dart';

// class SignInUpScreen extends StatelessWidget {
//   SignInUpScreen({super.key});

//   final cpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: {
//     "#": RegExp(r'[0-9]'),
//   });
//   final dataFormatter = MaskTextInputFormatter(mask: '##/##/####', filter: {
//     "#": RegExp(r'[0-9]'),
//   });

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(255, 143, 171, 1),
//       body: SingleChildScrollView(
//         child: SizedBox(
//           height: size.height,
//           width: size.width,
//           child: Column(
//             children: [
//               Expanded(
//                 child: Center(
//                   child: Text(
//                     'Cadastro',
//                     style: TextStyle(
//                       fontSize: 35,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 10,
//                 top: 10,
//                 child: SafeArea(
//                     child: IconButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         icon: Icon(
//                           Icons.arrow_back_ios,
//                           color: Colors.white,
//                         ))),
//               ),
//               //Formulário
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 32,
//                   vertical: 40,
//                 ),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(45),
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     CustomTextField(
//                       icon: Icons.person,
//                       label: 'Nome',
//                       decoration: InputDecoration(
//                         hintText: 'Digite seu nome',
//                       ),
//                     ),
//                     CustomTextField(
//                       icon: Icons.file_copy,
//                       label: 'CPF',
//                       inputFormatters: [cpfFormatter],
//                       decoration: InputDecoration(
//                         hintText: 'Digite seu CPF',
//                       ),
//                     ),
//                     CustomTextField(
//                       icon: Icons.date_range,
//                       label: 'Data de Nascimento',
//                       inputFormatters: [dataFormatter],
//                       decoration: InputDecoration(
//                         hintText: 'Digite sua data de Nascimento',
//                       ),
//                     ),
//                     CustomTextField(
//                       icon: Icons.email,
//                       label: 'E-mail',
//                       decoration: InputDecoration(
//                         hintText: 'Digite seu e-mail',
//                       ),
//                     ),
//                     CustomTextField(
//                       icon: Icons.lock,
//                       isSecret: true,
//                       label: 'Senha',
//                       decoration: InputDecoration(
//                         hintText: 'Digite sua Senha',
//                       ),
//                     ),
//                     CustomTextField(
//                       icon: Icons.lock,
//                       isSecret: true,
//                       label: 'Confirmar Senha',
//                       decoration: InputDecoration(
//                         hintText: 'Digite sua Senha novamente',
//                       ),
//                     ),
//                     SizedBox(
//                       height: 50,
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(18),
//                             ),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => SignInScreen()));
//                           },
//                           child: Text(
//                             'Cadastrar Usuário',
//                             style: TextStyle(fontSize: 18),
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   Future<void> mostrarCamposVaziosAlertDialog(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Tente novamente!'),
//           content: Text('Os campos não podem estar vazios.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> nomeInvalidoAlertDialog(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Tente novamente!'),
//           content: Text('O nome precisa conter pelo menos de 3 caracteres.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> cpfInvalidoAlertDialog(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Tente novamente!'),
//           content: Text('O CPF digitado é inválido.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> emailInvalidoAlertDialog(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Tente novamente!'),
//           content: Text('O email digitado é inválido.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> mostrarSenhasNaoCorrespondentesAlertDialog(
//       BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Tente novamente!'),
//           content: Text('As senhas digitadas são diferentes.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> mostrarSenhasMenoresOitoCaracteresAlertDialog(
//       BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Tente novamente!'),
//           content: Text('A senha precisa conter mais de 8 caracteres.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget build(BuildContext context) {
//     TextEditingController _nome = TextEditingController();
//     TextEditingController _cpf = TextEditingController();
//     TextEditingController _data = TextEditingController();
//     TextEditingController _email = TextEditingController();
//     TextEditingController _password = TextEditingController();
//     TextEditingController _confirmPassword = TextEditingController();
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 Container(
//                     margin: EdgeInsets.only(
//                         top: 180, left: 25, right: 25, bottom: 25),
//                     child: Text(
//                       'Primeiro Acesso',
//                       style:
//                           TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
//                     )),
//                 SizedBox(height: 30),
//                 Container(
//                   width: 500,
//                   child: TextFormField(
//                     controller: _nome,
//                     decoration: InputDecoration(
//                         labelText: 'Nome',
//                         labelStyle: TextStyle(color: Colors.black),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Color.fromRGBO(255, 143, 171, 1)))),
//                     cursorColor: Color.fromRGBO(255, 143, 171, 1),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Nome is required';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 Container(
//                   width: 500,
//                   child: TextFormField(
//                     controller: _cpf,
//                     inputFormatters: [
//                       FilteringTextInputFormatter.digitsOnly,
//                       CpfInputFormatter(),
//                     ],
//                     decoration: InputDecoration(
//                         labelText: 'CPF',
//                         labelStyle: TextStyle(color: Colors.black),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Color.fromRGBO(255, 143, 171, 1)))),
//                     cursorColor: Color.fromRGBO(255, 143, 171, 1),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'CPF is required';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 Container(
//                   width: 500,
//                   child: TextFormField(
//                     controller: _email,
//                     decoration: InputDecoration(
//                         labelText: 'Email',
//                         labelStyle: TextStyle(color: Colors.black),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Color.fromRGBO(255, 143, 171, 1)))),
//                     cursorColor: Color.fromRGBO(255, 143, 171, 1),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Email is required';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 Container(
//                   width: 500,
//                   child: TextFormField(
//                     inputFormatters: [
//                       FilteringTextInputFormatter.digitsOnly,
//                       DataInputFormatter(),
//                     ],
//                     controller: _data,
//                     decoration: InputDecoration(
//                         labelText: 'Data de Nascimento',
//                         labelStyle: TextStyle(color: Colors.black),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Color.fromRGBO(255, 143, 171, 1)))),
//                     cursorColor: Color.fromRGBO(255, 143, 171, 1),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Data de nascimento is required';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 Container(
//                   width: 500,
//                   child: TextFormField(
//                     controller: _password,
//                     decoration: InputDecoration(
//                         labelText: 'Password',
//                         labelStyle: TextStyle(color: Colors.black),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Color.fromRGBO(255, 143, 171, 1)))),
//                     cursorColor: Color.fromRGBO(255, 143, 171, 1),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Password is required';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 Container(
//                   width: 500,
//                   child: TextFormField(
//                     controller: _confirmPassword,
//                     decoration: InputDecoration(
//                         labelText: 'Confirm Password',
//                         labelStyle: TextStyle(color: Colors.black),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Color.fromRGBO(255, 143, 171, 1)))),
//                     cursorColor: Color.fromRGBO(255, 143, 171, 1),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please confirm your password';
//                       }
//                       if (value != _password.text) {
//                         return 'Passwords do not match';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_nome.text.isEmpty ||
//                         _cpf.text.isEmpty ||
//                         _email.text.isEmpty ||
//                         _data.text.isEmpty ||
//                         _password.text.isEmpty ||
//                         _confirmPassword.text.isEmpty) {
//                       mostrarCamposVaziosAlertDialog(context);
//                       return;
//                     }

//                     if (_nome.text.length < 3) {
//                       nomeInvalidoAlertDialog(context);
//                       return;
//                     }

//                     if (!GetUtils.isCpf(_cpf.text)) {
//                       cpfInvalidoAlertDialog(context);
//                       return;
//                     }

//                     if (!_email.text.contains("@") ||
//                         !_email.text.contains(".com")) {
//                       emailInvalidoAlertDialog(context);
//                       return;
//                     }

//                     if (_password.text.length < 8) {
//                       mostrarSenhasMenoresOitoCaracteresAlertDialog(context);
//                       return;
//                     }
//                     if (_password.text != _confirmPassword.text) {
//                       mostrarSenhasNaoCorrespondentesAlertDialog(context);
//                       return;
//                     }

//                     bool loggedIn = await RegisterService.getRegister(
//                         _nome.text,
//                         _cpf.text,
//                         _email.text,
//                         _data.text,
//                         _password.text);
//                     if (loggedIn) {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => SignInScreen()));
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color.fromRGBO(255, 143, 171, 1),
//                     alignment: Alignment.center,
//                   ),
//                   child: Container(
//                     width: 465,
//                     height: 39,
//                     child: Center(child: Text('CADASTRAR')),
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => SignInScreen(),
//                         ));
//                   },
//                   child: Text(
//                     'JÁ POSSUI CONTA?',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontSize: 15, color: Color.fromRGBO(255, 143, 171, 1)),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
