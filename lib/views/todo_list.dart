import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertodo/common/show_model.dart';
import 'package:fluttertodo/provider/date_time_provider.dart';
import 'package:fluttertodo/provider/service_provider.dart';
import 'package:fluttertodo/widget/card_todoList_widget.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class TodoList extends ConsumerWidget{
  const TodoList({
    super.key,
  });

@override
Widget build(BuildContext context, WidgetRef ref){
  final todoData = ref.watch(fetchStreamProvider);
  DateTime now = DateTime.now();
  String formattedDate = DateFormat.yMMMEd().format(now);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.deepOrange,
            radius: 25,
            child: Image.asset('assets/avatar.png'),
          ),
          title: Text(
            'Olá, bem vindo(a)',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
          subtitle: const Text(
            'Clarissa Giselly',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(CupertinoIcons.calendar)),
              IconButton(
                  onPressed: () {}, icon: const Icon(CupertinoIcons.bell))
            ]),
          )
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(children: [
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Atividades do dia',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Text(formattedDate,
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: () => showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      context: context,
                      builder: (context) => AddNewTaskModel()),
                  child: const Text('+ Adicionar Atv'))
            ],
          ),

          //Card list task
          const Gap(20),
          ListView.builder(
            itemCount: todoData.value!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => CardTodoListWidget(getIndex: index))
        ]),
      )),
    );
}
}