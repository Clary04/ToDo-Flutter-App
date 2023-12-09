// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
   String? docID;
   final String Titulo; 
   final String Descricao;
   final String Categoria;
   final String Data;
   final String Tempo;
   final bool Feita;

  TodoModel({
  this.docID,
  required this.Titulo, 
  required this.Descricao, 
  required this.Categoria, 
  required this.Data, 
  required this.Tempo,
  required this.Feita
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Titulo': Titulo,
      'Descricao': Descricao,
      'Categoria': Categoria,
      'Data': Data,
      'Tempo': Tempo,
      'Feita': Feita
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
      Titulo: map['Titulo'] as String,
      Descricao: map['Descricao'] as String,
      Categoria: map['Categoria'] as String,
      Data: map['Data'] as String,
      Tempo: map['Tempo'] as String,
      Feita: map['Feita'] as bool
    );
  }

   factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc){
    return TodoModel(docID: doc.id, Titulo: doc['Titulo'], Descricao: doc['Descricao'], Categoria: doc['Categoria'], Data: doc['Data'], Tempo: doc['Tempo'], Feita: doc['Feita']);
   }
}
