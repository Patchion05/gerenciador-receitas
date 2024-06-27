import 'dart:convert';

import 'package:fitness_tracker/edit_exercise_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListExercisesScreen extends StatefulWidget {
  @override
  _ListExercisesScreenState createState() => _ListExercisesScreenState();
}

class _ListExercisesScreenState extends State<ListExercisesScreen> {
  final String baseUrl =
      'https://gerenciador-de-receitas2-default-rtdb.firebaseio.com/';
  List<Map<String, dynamic>> exercises = [];

  @override
  void initState() {
    super.initState();
    _fetchExercises();
  }

  Future<void> _fetchExercises() async {
    final response = await http.get(Uri.parse('$baseUrl/exercises.json'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data != null) {
        setState(() {
          exercises = data.entries.map((entry) {
            return {"key": entry.key, ...entry.value as Map<String, dynamic>};
          }).toList();
        });
      }
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Receitas'),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(exercises[index]['type']),
            subtitle: Text(
                '${exercises[index]['duration']} min - ${exercises[index]['calories']} cal - ${exercises[index]['date']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditExerciseScreen(exercise: exercises[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
