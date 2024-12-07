import 'package:flutter/material.dart';

// 1. Point d'entrée de l'application - Lance l'application Flutter
void main() {
  runApp(const MyApp());
}

// 2. Widget racine de l'application (stateless car l'interface globale ne change pas)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO APP',
      theme: ThemeData(
        // Définit le thème de l'application avec une couleur de base bleue
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(115, 70, 182, 247)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

// 3. Page d'accueil (stateful car gère une liste de tâches dynamique)
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 4. État de la page d'accueil qui contient la logique et les données
class _MyHomePageState extends State<MyHomePage> {
  // Liste des tâches stockées sous forme de Map avec titre et état
  final List<Map<String, dynamic>> _tasks = [];

  // Ajoute une nouvelle tâche à la liste
  void _addTask(String task) {
    setState(() {
      _tasks.add({'title': task, 'completed': false});
    });
  }

  // Supprime une tâche à l'index spécifié
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  // Inverse l'état (complété/non complété) d'une tâche
  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['completed'] = !_tasks[index]['completed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('TODO APP'),
        centerTitle: true,
      ),
      // Corps principal de l'application avec la liste des tâches
      body: _tasks.isEmpty 
          ? const Center(
              child: Text('Aucune tâche pour le moment'),
            )
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  // Affiche le titre de la tâche
                  title: Text(
                    _tasks[index]['title'],
                    style: TextStyle(
                      decoration: _tasks[index]['completed'] 
                          ? TextDecoration.lineThrough 
                          : null,
                    ),
                  ),
                  // Case à cocher pour marquer une tâche comme terminée
                  leading: Checkbox(
                    value: _tasks[index]['completed'],
                    onChanged: (bool? value) {
                      _toggleTask(index);
                    },
                  ),
                  // Bouton pour supprimer une tâche
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteTask(index),
                  ),
                );
              },
            ),
      // Bouton flottant pour ajouter une nouvelle tâche
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String newTask = '';
              return AlertDialog(
                title: const Text('Nouvelle tâche'),
                content: TextField(
                  autofocus: true,
                  onChanged: (value) {
                    newTask = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Entrez votre tâche',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Annuler'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (newTask.isNotEmpty) {
                        _addTask(newTask);
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('Ajouter'),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Ajouter une tâche',
        child: const Icon(Icons.add),
      ),
    );
  }
}
