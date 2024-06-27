import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddExerciseScreen extends StatefulWidget {
  @override
  _AddExerciseScreenState createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  final _durationController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _typeController.dispose();
    _durationController.dispose();
    _caloriesController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _addExercise() async {
    if (_formKey.currentState!.validate()) {
      final String baseUrl =
          'https://gerenciador-de-receitas2-default-rtdb.firebaseio.com/';
      final response = await http.post(
        Uri.parse('$baseUrl/exercises.json'),
        body: json.encode({
          'type': _typeController.text,
          'duration': _durationController.text,
          'calories': _caloriesController.text,
          'date': _dateController.text,
        }),
      );
      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        // Handle error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Receitas'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Nome da receitas'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o nome da receitas';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _durationController,
                decoration: InputDecoration(labelText: 'Ingredientes'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira os Ingredientes';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _caloriesController,
                decoration: InputDecoration(labelText: 'Modo de preparo'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o modo de preparo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Tempo de Preparo'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o Tempo de Preparo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addExercise,
                child: Text('Adicionar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
