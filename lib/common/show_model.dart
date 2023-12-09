import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertodo/constants/app_style.dart';
import 'package:fluttertodo/model/todo_model.dart';
import 'package:fluttertodo/provider/date_time_provider.dart';
import 'package:fluttertodo/provider/radio_provider.dart';
import 'package:fluttertodo/provider/service_provider.dart';
import 'package:fluttertodo/widget/datetime_widget.dart';
import 'package:fluttertodo/widget/radio_widget.dart';
import 'package:fluttertodo/widget/textField_widget.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class AddNewTaskModel extends ConsumerWidget {
   AddNewTaskModel({
    super.key,
  });

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);
    return Container(
    padding: const EdgeInsets.all(30),
    height: MediaQuery.of(context).size.height * 0.70,
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: double.infinity,
          child: Text(
            'Nova Atividade',
             textAlign: TextAlign.center,
             style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black
             ),
            ),
        ),
      Divider(
        thickness: 1.5,
        color: Colors.grey.shade200,
      ),
      const Gap(12),
      const Text('Título da Atividade', style: AppStyle.headingStyleOne),
      const Gap(6),
      TextFieldWidget(maxLine: 1, hintText: 'Adicione um nome para à atividade', textEditingController: titleController,),
      const Gap(12),
      const Text('Descrição', style: AppStyle.headingStyleOne),
      const Gap(6),
      TextFieldWidget(maxLine: 5, hintText: 'Adicione uma descrição à atividade', textEditingController: descriptionController,),
      const Gap(12),
      const Text('Categoria', style: AppStyle.headingStyleOne),
       Row(
        children: [
          Expanded(child: RadioWidget(categoryColor: Colors.purple, titleRadio: 'Estudo', valueInput: 1, onChangeValue: () => ref.read(radioProvider.notifier).update((state) => 1))),

          Expanded(child: RadioWidget(categoryColor: Colors.blue, titleRadio: 'Trabalho', valueInput: 2, onChangeValue: () => ref.read(radioProvider.notifier).update((state) => 2))),

          Expanded(child: RadioWidget(categoryColor: Colors.deepOrange, titleRadio: 'Outros', valueInput: 3, onChangeValue: () => ref.read(radioProvider.notifier).update((state) => 3)))
        ],
      ),

      //Date and Time Section
      const Gap(12),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DateTimeWidget(titleDateTimeText: 'Data', 
          valueDateTimeText: dateProv,
           iconItem: CupertinoIcons.calendar, 
           onTap: () async { 
            
            final getValue = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2021), lastDate: DateTime(2025)); 
           
            if(getValue != null){
              final format = DateFormat.yMd();
              ref.read(dateProvider.notifier).update((state) => format.format(getValue));
            }

           }),
          const Gap(22),
          DateTimeWidget(titleDateTimeText: 'Tempo', 
          valueDateTimeText: ref.watch(timeProvider), 
          iconItem: CupertinoIcons.clock, 
          onTap: () async {
            final getTimeValue = await showTimePicker(context: context, initialTime: TimeOfDay.now());
          
            if(getTimeValue != null){
              ref.read(timeProvider.notifier).update((state) => getTimeValue.format(context));
            }
          }),
        ],
      ),

    //Button Actions Section
      const Gap(12),
      Row(children: [
        Expanded(child: 
            ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.grey.shade800,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              side: const BorderSide(color: Colors.grey),
              padding: const EdgeInsets.symmetric(vertical: 13)
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
        )),
        const Gap(20),
        Expanded(child: 
            ElevatedButton(
             style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              padding: const EdgeInsets.symmetric(vertical: 13)
             ),  
            onPressed: () {
              final getRadioVlue = ref.read(radioProvider);
              String category = '';

              switch(getRadioVlue){

                case 1:
                category = 'Estudo'; 
                break;
                case 2: 
                category = 'Trabalho';
                break;
                case 3:
                category = 'Outros';
                break;
              }

              ref.read(serviceProvider).addNewTask(
                TodoModel(
                  Titulo: titleController.text, 
                  Descricao: descriptionController.text, 
                  Categoria: category, 
                  Data: ref.read(dateProvider), 
                  Tempo: ref.read(timeProvider),
                  Feita: false
                  ));
            
              titleController.clear();
              descriptionController.clear();
              ref.read(radioProvider.notifier).update((state) => 0);
              ref.read(dateProvider.notifier).update((state) => 'dd/mm/yy');
              ref.read(timeProvider.notifier).update((state) => 'hh : mm');
              Navigator.pop(context);
            },
            child: const Text('Criar'),
        )),
      ],),
       
    ]),
    );
  }
}


