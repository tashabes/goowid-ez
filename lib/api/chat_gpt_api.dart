// import 'dart:convert';
// import 'dart:html';

// Future<String> generateResponse(String prompt) async {
//   final apiKey = apiSecretKey;
//   var url = Uri.https("api.openai.com", "/v1/completions");
//   final response = await http.post(url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $apiKey'
//       },
//       body: jsonEncode({
//         'model': 'text-davinci-003',
//         'prompt': prompt,
//         'temperature': 0,
//         'max_token': 2000,
//         'top_p': 1,
//         'frequency_penalty': 0.0,
//         'presence_penalty': 0.0
//       }));

//   //decode the response

//   Map<String, dynamic> newresponse = jsonDecode(response.body);
//   return newresponse['choices'][0]['text'];
// }


// Using Future delayed to order tasks on pressed

// Future.delayed(Duration(milliseconds: 50))
// .then((value) => function());