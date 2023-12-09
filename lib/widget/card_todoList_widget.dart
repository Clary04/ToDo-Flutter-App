import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertodo/provider/service_provider.dart';
import 'package:gap/gap.dart';

class CardTodoListWidget extends ConsumerWidget {
  const CardTodoListWidget({
    super.key,
    required this.getIndex
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return todoData.when(
    data: (todoData) {
      Color categoryColor = Colors.white;
      final getCategory = todoData[getIndex].Categoria;

      switch(getCategory){

        case 'Estudo':
         categoryColor = Colors.purple;
         break;
        case 'Trabalho':
        categoryColor = Colors.blue;
         break;
        case 'Outros':
        categoryColor = Colors.deepOrange;
        break;
      }

      return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Container(
          decoration: BoxDecoration(
              color: categoryColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12))),
          width: 20,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: IconButton(icon: const Icon(CupertinoIcons.delete), onPressed: () => ref.read(serviceProvider).deleteTask(todoData[getIndex].docID) ,),
                  title: Text(todoData[getIndex].Titulo, maxLines: 1, style: TextStyle( decoration: todoData[getIndex].Feita ? TextDecoration.lineThrough : null)),
                  subtitle: Text(
                    todoData[getIndex].Descricao, 
                    maxLines: 1,
                    style: TextStyle( decoration: todoData[getIndex].Feita ? TextDecoration.lineThrough : null),),
                  trailing: Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      activeColor: Colors.green,
                      shape: const CircleBorder(),
                      value: todoData[getIndex].Feita,
                      onChanged: (value) => ref.read(serviceProvider).updateTask(todoData[getIndex].docID, value),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -12),
                  child: Container(
                    child: Column(children: [
                      Divider(thickness: 1.5, color: Colors.grey.shade500),
                      Row(
                        children: [
                          const Text('Today'),
                          const Gap(12),
                          Text(todoData[getIndex].Tempo)
                        ],
                      )
                    ]),
                  ),
                )
              ]),
        ))
      ]),
    );
    }, 
    error: (error, stackTrace) => Center(child: Text(stackTrace.toString()),), 
    loading: () => const Center(child: CircularProgressIndicator()));
  }
}