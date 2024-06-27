import 'package:fitness_tracker/add_exercise_scr.dart';
import 'package:fitness_tracker/list_receitas_pesquisar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciador de Receitas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddExerciseScreen()),
                );
              },
              child: Text('Adicionar Receitas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListExercisesScreen()),
                );
              },
              child: Text('Listar Receitas'),
            ),
          ],
        ),
      ),
    );
  }
}
