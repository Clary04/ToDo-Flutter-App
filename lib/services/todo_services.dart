import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertodo/model/todo_model.dart';

class TodoService{
  final todoCollection = FirebaseFirestore.instance.collection('todo-application');

  void addNewTask(TodoModel model){
    todoCollection.add(model.toMap());
  }

  void updateTask(String? docID, bool? valueUpdate){
    todoCollection.doc(docID).update({
      'Feita': valueUpdate
    });
  }

  void deleteTask(String? docID){
    todoCollection.doc(docID).delete();
  }
}