import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FormTarefa extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String? nome;
  String? descricao;

  salvar(BuildContext context,
      {int? id, required String nome, required String descricao}) async {
    var caminho = join(await getDatabasesPath(), 'bancofinal.db');
    var banco = await openDatabase(caminho);
    String sql;
    if (id == null) {
      sql = 'INSERT INTO tarefa (nome, descricao) VALUES (?, ?)';
      banco.rawInsert(sql, [nome, descricao]);
    } else {
      sql = 'UPDATE tarefa SET nome = ?, descricao = ? HWERE id = ?';
    }
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Tarefa')),
      body: Container(
          child: Form(
              child: Column(
        children: [
          TextField(
              decoration: const InputDecoration(labelText: "Nome:"),
              keyboardType: TextInputType.text,
              onChanged: (String val) {
                nome = val;
              }),
          TextField(
              decoration: const InputDecoration(labelText: "Descrição:"),
              keyboardType: TextInputType.text,
              onChanged: (String val) {
                descricao = val;
              }),
          ElevatedButton(
            onPressed: () =>
                salvar(context, nome: nome!, descricao: descricao!),
            child: const Text("Salvar"),
          )
        ],
      ))),
    );
  }
}
