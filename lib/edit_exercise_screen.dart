import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditExerciseScreen extends StatefulWidget {
  final Map<String, dynamic> exercise;

  const EditExerciseScreen({super.key, required this.exercise});

  @override
  _EditExerciseScreenState createState() => _EditExerciseScreenState();
}

class _EditExerciseScreenState extends State<EditExerciseScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _typeController;
  late TextEditingController _durationController;
  late TextEditingController _caloriesController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _typeController = TextEditingController(text: widget.exercise['type']);
    _durationController =
        TextEditingController(text: widget.exercise['duration']);
    _caloriesController =
        TextEditingController(text: widget.exercise['calories']);
    _dateController = TextEditingController(text: widget.exercise['date']);
  }

  Future<void> _editExercise() async {
    if (_formKey.currentState!.validate()) {
      const String baseUrl =
          'https://gerenciador-de-receitas2-default-rtdb.firebaseio.com/22222222';
      final response = await http.patch(
        Uri.parse('$baseUrl/exercises/${widget.exercise['key']}.json'),
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
  void dispose() {
    _typeController.dispose();
    _durationController.dispose();
    _caloriesController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Receitas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _typeController,
                decoration:
                    const InputDecoration(labelText: 'Tempo de Receitas'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o Tempo de Receitas';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(labelText: 'Modo de Preparo'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o modo de Preparo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _caloriesController,
                decoration:
                    const InputDecoration(labelText: 'Calorias Queimadas'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira as ';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Data'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira a data';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _editExercise,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
