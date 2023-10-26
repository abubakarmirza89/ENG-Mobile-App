import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:engenglish/Globals/globals.dart' as globals;

Future<List<dynamic>> fetchUserList() async {
  final String apiUrl = 'https://engenglish.com/api/users/users/all';

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer ${globals.accessToken}',
    },
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON data.
    return json.decode(response.body);
  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load user list');
  }
}



void main() async {
  try {
    List<dynamic> userList = await fetchUserList();
    // Now you can work with the userList data.
    print(userList);
  } catch (e) {
    print('Error: $e');
  }
}