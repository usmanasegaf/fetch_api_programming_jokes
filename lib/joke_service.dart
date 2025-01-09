import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fetch_api_programming_jokes/joke.dart';

class JokeService {
  final String _baseUrl =
      'https://official-joke-api.appspot.com/jokes/programming/ten';

  Future<List<Joke>> fetchJokes() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((joke) => Joke.fromJson(joke)).toList();
    } else {
      throw Exception('Failed to load jokes');
    }
  }
}
