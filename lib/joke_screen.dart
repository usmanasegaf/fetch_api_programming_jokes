import 'package:flutter/material.dart';
import 'package:fetch_api_programming_jokes/joke_service.dart';
import 'package:fetch_api_programming_jokes/joke.dart';

class JokeScreen extends StatefulWidget {
  @override
  _JokeScreenState createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  final JokeService _jokeService = JokeService();
  List<Joke> _jokes = [];
  bool _isLoading = false;
  String _error = '';

  void _loadJokes() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final jokes = await _jokeService.fetchJokes();
      setState(() {
        _jokes = jokes;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load jokes. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadJokes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programming Jokes'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _error.isNotEmpty
                ? Text(_error)
                : _jokes.isNotEmpty
                    ? ListView.builder(
                        itemCount: _jokes.length,
                        itemBuilder: (context, index) {
                          final joke = _jokes[index];
                          return Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    joke.setup,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    joke.punchline,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Text('No jokes available.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadJokes,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
