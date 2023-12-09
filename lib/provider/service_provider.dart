import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertodo/model/todo_model.dart';
import 'package:fluttertodo/services/todo_services.dart';

final serviceProvider = StateProvider<TodoService>((ref) => TodoService()
);


final fetchStreamProvider = StreamProvider<List<TodoModel>>((ref) async* {
  final getData = FirebaseFirestore.instance.
     collection('todo-application')
     .snapshots()
     .map((event) => event.docs.map((snapshot) => TodoModel.fromSnapshot(snapshot)).toList());
  yield* getData;
});

