Link para o video do Youtube: https://youtu.be/shS9McokQl4
Esse código em Dart e Flutter cria uma tela para adicionar receitas em um aplicativo móvel. Vamos explicar passo a passo o que cada parte faz:

Codigo:
import 'dart:convert'; 
import 'package:flutter/material.dart'; 
import 'package:gerenciador_para_receitas/constants.dart';
import 'package:http/http.dart' as http;

Explicação:
: Biblioteca para manipulação de dados JSON.
flutter/material.dart: Biblioteca principal do Flutter para construir a interface gráfica.
gerenciador_para_receitas/constants.dart: Importa constantes específicas, como URLs.
http: Permite fazer requisições HTTP, renomeado como http.

Codigo:
class AddReceitaScr extends StatefulWidget {
  const AddReceitaScr({super.key});

  @override
  _AddExerciseScreenState createState() => _AddExerciseScreenState();
}

Explicação:
Define um widget stateful (StatefulWidget) chamado AddReceitaScr.
Implementa o método createState para criar o estado associado (_AddExerciseScreenState).

Codigo:
class _AddExerciseScreenState extends State<AddReceitaScr> {
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

  // Métodos e widgets relacionados à interface da tela e manipulação de dados.
}

Explicação:
Define o estado para o widget AddReceitaScr.
Declara controladores para os campos de entrada (TextEditingController).
dispose(): Libera recursos dos controladores quando o widget é removido.

Codigo:
Future<void> _addExercise() async {
  if (_formKey.currentState!.validate()) {
    const String baseUrl = Constant.DB_URL;
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

Explicação:
Método assíncrono para adicionar uma nova receita.
Valida o formulário (_formKey.currentState!.validate()).
Envia uma requisição POST para adicionar os dados da receita para uma URL específica.
Fecha a tela atual se a operação for bem-sucedida (Navigator.pop(context)).

Codigo: 
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Adicionar Receitas'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Campos de texto para nome da receita, ingredientes, modo de preparo e tempo de preparo.
            // Botão para adicionar a receita.
          ],
        ),
      ),
    ),
  );
}

Explicação:
Constrói a interface da tela usando Scaffold com um AppBar e Padding.
Usa um formulário (Form) com campos de texto (TextFormField) para inserir dados da receita.
Inclui um botão (ElevatedButton) para adicionar a receita, que chama o método _addExercise().



Esse código em Dart e Flutter cria uma tela para editar informações de uma receita em um aplicativo móvel. Vamos explicar cada parte detalhadamente:

Codigo:
import 'dart:convert'; 
import 'package:flutter/material.dart'; 
import 'package:gerenciador_para_receitas/constants.dart';
import 'package:http/http.dart' as http;

Explicação:
dart
: Biblioteca para manipulação de dados JSON.
flutter/material.dart: Biblioteca principal do Flutter para construir a interface gráfica.
gerenciador_para_receitas/constants.dart: Importa constantes específicas, como URLs.
http: Permite fazer requisições HTTP, renomeado como http.

Codigo:
class EditExerciseScreen extends StatefulWidget {
  final Map<String, dynamic> exercise;

  const EditExerciseScreen({super.key, required this.exercise});

  @override
  _EditExerciseScreenState createState() => _EditExerciseScreenState();
}

Explicação:
Define um widget stateful (StatefulWidget) chamado EditExerciseScreen.
Recebe um parâmetro exercise, que é um mapa contendo os dados da receita a ser editada.

Codigo:
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
    _durationController = TextEditingController(text: widget.exercise['duration']);
    _caloriesController = TextEditingController(text: widget.exercise['calories']);
    _dateController = TextEditingController(text: widget.exercise['date']);
  }

  @override
  void dispose() {
    _typeController.dispose();
    _durationController.dispose();
    _caloriesController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _editExercise() async {
    if (_formKey.currentState!.validate()) {
      const String baseUrl = Constant.DB_URL;
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
              // Campos de texto para tipo, duração, calorias e data da receita.
              // Botão para salvar as alterações.
            ],
          ),
        ),
      ),
    );
  }
}

Explicação:
Define o estado (State) para o widget EditExerciseScreen.
initState(): Método chamado quando o estado do widget é inicializado, utilizado aqui para preencher os controladores com os dados atuais da receita.
dispose(): Método chamado quando o widget é removido da árvore de widgets, usado para liberar recursos dos controladores.
_editExercise(): Método assíncrono para editar a receita. Valida o formulário, envia uma requisição PATCH HTTP para atualizar os dados da receita no servidor. Se a operação for bem-sucedida (código de status 200), fecha a tela de edição (Navigator.pop(context)).
build(BuildContext context): Método que constrói a interface da tela, usando Scaffold, AppBar, Padding, Form, TextFormField para os campos de edição e um botão (ElevatedButton) para salvar as alterações.




Este código em Dart e Flutter define a tela inicial (HomeScreen) de um aplicativo de gerenciamento de receitas. Vamos analisar seu funcionamento:

Codigo:
import 'package:flutter/material.dart';
import 'package:gerenciador_para_receitas/add_receita_scr.dart';
import 'package:gerenciador_para_receitas/list_receitas_pesquisar.dart';

Explicação:
flutter/material.dart: Importa a biblioteca principal do Flutter para construir a interface gráfica.
add_receita_scr.dart: Importa a tela de adicionar receitas (AddReceitaScr).
list_receitas_pesquisar.dart: Importa a tela de listar receitas (ListExercisesScreen).


Codigo:
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciador de Receitas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddReceitaScr(),
                  ),
                );
              },
              child: const Text('Adicionar Receitas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListExercisesScreen(),
                  ),
                );
              },
              child: const Text('Listar Receitas'),
            ),
          ],
        ),
      ),
    );
  }
}


Explicação:
HomeScreen: É um widget sem estado (StatelessWidget), ou seja, não mantém estado interno.
Método build(BuildContext context):

Constrói a interface da tela utilizando Scaffold, que é uma estrutura básica com um AppBar na parte superior e um body centralizado.
AppBar: Define um título para a barra superior com o texto "Gerenciador de Receitas".
body: Center(...): Centraliza o conteúdo da tela.
Column(...): Organiza os widgets verticalmente em uma coluna.
mainAxisAlignment: MainAxisAlignment.center: Alinha os widgets verticalmente ao centro da coluna.
Botões (ElevatedButton):
"Adicionar Receitas": Um botão elevado (ElevatedButton) que, quando pressionado (onPressed), utiliza o Navigator.push para navegar para a tela AddReceitaScr, onde o usuário pode adicionar novas receitas.
"Listar Receitas": Outro botão elevado que, quando pressionado, navega para a tela ListExercisesScreen, onde serão listadas as receitas existentes.
Funcionamento:

Ao pressionar qualquer um dos botões ("Adicionar Receitas" ou "Listar Receitas"), o método onPressed é ativado, navegando para a tela correspondente usando o Navigator.push.
A navegação é realizada usando MaterialPageRoute, que define a transição para a nova tela (AddReceitaScr ou ListExercisesScreen).




Este código em Dart e Flutter cria uma tela para listar receitas, buscando dados de um banco de dados remoto e exibindo-os dinamicamente em uma lista. Vamos analisar detalhadamente como ele funciona:

Codigo:
import 'dart:convert'; 
import 'package:flutter/material.dart'; 
import 'package:gerenciador_para_receitas/constants.dart';
import 'package:gerenciador_para_receitas/edit_receita_screen.dart';
import 'package:http/http.dart' as http;

Explicação:
dart
: Biblioteca para manipulação de dados JSON.
flutter/material.dart: Biblioteca principal do Flutter para construir a interface gráfica.
gerenciador_para_receitas/constants.dart: Importa constantes específicas, como URLs de banco de dados.
edit_receita_screen.dart: Importa a tela de edição de receitas (EditExerciseScreen).
http: Permite fazer requisições HTTP, renomeado como http.

Codigo:
class ListExercisesScreen extends StatefulWidget {
  const ListExercisesScreen({super.key});

  @override
  _ListExercisesScreenState createState() => _ListExercisesScreenState();
}

Explicação:
ListExercisesScreen: É um widget stateful (StatefulWidget) que mantém um estado interno.

Codigo:
class _ListExercisesScreenState extends State<ListExercisesScreen> {
  final String baseUrl = Constant.DB_URL;
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
      setState(() {
        exercises = data.entries.map((entry) {
          return {"key": entry.key, ...entry.value as Map<String, dynamic>};
        }).toList();
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Receitas'),
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
                  builder: (context) => EditExerciseScreen(
                      exercise: exercises[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


Explicação:
_ListExercisesScreenState: É a classe de estado associada ao widget ListExercisesScreen.
baseUrl: Uma constante que representa a URL base do banco de dados onde estão armazenadas as receitas.
exercises: Uma lista que armazena os dados das receitas obtidas do banco de dados.
Método initState():

É chamado quando o widget é inserido na árvore de widgets.
Chama _fetchExercises(), que é responsável por fazer uma requisição HTTP GET para buscar os dados das receitas no banco de dados.
Método Future<void> _fetchExercises() async:

É assíncrono e faz uma requisição HTTP GET para a URL '$baseUrl/exercises.json'.
Verifica se a resposta é bem-sucedida (código 200).
Decodifica os dados JSON da resposta e atualiza o estado (exercises) com os dados obtidos.
Método build(BuildContext context):

Constrói a interface da tela utilizando Scaffold.
Define um AppBar com o título "Lista de Receitas".
Utiliza um ListView.builder para construir uma lista de itens de forma dinâmica, com base na lista exercises.
Para cada item da lista, utiliza um ListTile que exibe o tipo da receita no título e a duração, calorias e data da receita como subtítulo.
Define um onTap para cada ListTile, onde ao ser pressionado, navega para a tela EditExerciseScreen, passando os dados da receita selecionada através do construtor exercise.




Este código em Dart e Flutter cria um aplicativo simples que gerencia receitas. Vamos explorar suas partes principais:

Codigo:
import 'package:flutter/material.dart';
import 'package:gerenciador_para_receitas/home_screen.dart';


Explicação:
flutter/material.dart: Importa a biblioteca principal do Flutter para construir a interface gráfica.
gerenciador_para_receitas/home_screen.dart: Importa o arquivo home_screen.dart, que contém a definição da tela inicial do aplicativo.

Codigo:
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

Explicação:
main(): Ponto de entrada principal do aplicativo Flutter.
WidgetsFlutterBinding.ensureInitialized(): Garante que os bindings do Flutter estão inicializados antes de executar o aplicativo. É útil especialmente para operações assíncronas que ocorrem durante a inicialização do aplicativo.
runApp(const MyApp()): Inicia a execução do aplicativo, passando uma instância de MyApp como widget raiz.

Codigo:
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gerenciador de Receitas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

Explicação:
MyApp: É um widget sem estado (StatelessWidget) que define o aplicativo principal.
Construtor MyApp: Define um construtor padrão para o widget.
build(BuildContext context): Método obrigatório que constrói a interface do widget.
MaterialApp: Widget que define a estrutura básica do aplicativo seguindo as diretrizes do Material Design.
debugShowCheckedModeBanner: false: Desativa a exibição do banner de debug no canto superior direito do aplicativo durante o desenvolvimento.
title: 'Gerenciador de Receitas': Define o título do aplicativo.
theme: ThemeData(...): Define o tema do aplicativo, aqui configurado com a cor primária azul (Colors.blue).
home: const HomeScreen(): Define a tela inicial do aplicativo como HomeScreen(), que é importada no início do arquivo.
Classe HomeScreen (não mostrada diretamente neste código):

É uma tela que provavelmente contém botões para adicionar e listar receitas, conforme visto em um dos códigos anteriores que importam home_screen.dart.
