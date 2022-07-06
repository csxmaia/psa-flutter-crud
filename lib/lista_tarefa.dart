import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ListaTarefa extends StatelessWidget{

  Future<List<Map<String, Object?>>> buscarDados() async {
    String caminhoBD = join(await getDatabasesPath(), 'banco.db');
    Database banco = await openDatabase(
      caminhoBD,
      version: 1,
      onCreate: (db, version){
        db.execute("""
          CREATE TABLE tarefa(
            id INTEGER PRIMARY KEY
            nome TEXT NOT NULL,
            descricao TEXT NOT NULL
          )
        """);
        db.execute('INSERT INTO tarefa (nome, descricao) VALUES ("CADASTRO", "DSA")');
        db.execute('INSERT INTO tarefa (nome, descricao) VALUES ("APRESENTACAO", "CS")');
        db.execute('INSERT INTO tarefa (nome, descricao) VALUES ("LISTA EXE", "G")');
      }
    );
    List<Map<String, Object?>> tarefas = await banco.rawQuery('SELECT * FROM tarefa');
    return tarefas;
  }

  @override
  Widget build(BuildContext context) {
    buscarDados();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tarefas"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/formTarefa'),
          )
        ]
      ),
      body: FutureBuilder(
        future: buscarDados(),
        builder: (context, AsyncSnapshot<List<Map<String, Object?>>> dadosFuturos){
          if(!dadosFuturos.hasData) return const CircularProgressIndicator();
          var tarefas = dadosFuturos.data!;
          return ListView.builder(
            itemCount: tarefas.length, 
            itemBuilder: (context, contador){
              var tarefa = tarefas[contador];
              return ListTile(
                title: Text(tarefa['nome'].toString()),
                subtitle: Text(tarefa['descricao'].toString())
              );
            }
          );
        }
      ),
    );
  }
}