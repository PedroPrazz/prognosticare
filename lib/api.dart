import 'dart:convert';

String urLBase = 'http://localhost:8080/';

getID(id) async {
  var url = Uri.parse(urLBase);
  var http;
  var response = await http.get(url);
  var data = await jsonDecode(response.body);
  return data;
}

postLogin(email, password) async {
  var url = Uri.parse(urLBase + '/login');
  var http;
  var response = await http.get(url);
  var data = await jsonDecode(response.body);
  return data;
}

// postCadastro(cpf, email, datanas, password) async {
//   var url = Uri.parse(urLBase + '/cadastro');
//   var http;
//   var response = await http.get(url);
//   var data = await jsonDecode(response.body);
//   return data;
// }

// postFindbyId(id) async {
//   var url = Uri.parse(urLBase + '/findbyId');
//   var http;
//   var response = await http.get(url);
//   var data = await jsonDecode(response.body);
//   return data;
// }

