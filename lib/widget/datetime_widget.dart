import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertodo/constants/app_style.dart';
import 'package:gap/gap.dart';

class DateTimeWidget extends ConsumerWidget {
  const DateTimeWidget({
    super.key,
    required this.titleDateTimeText,
    required this.valueDateTimeText,
    required this.iconItem,
    required this.onTap

  });

  final String titleDateTimeText; 
  final String valueDateTimeText;
  final IconData iconItem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         children: [
          Text(titleDateTimeText, style: AppStyle.headingStyleOne),
          const Gap(6),
          Material(
            child: Ink(
                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => onTap(),
                child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(color: Colors.transparent,
                borderRadius: BorderRadius.circular(8)
                ),
                child: Row(children: [
                  Icon(iconItem),
                  const Gap(6),
                  Text(valueDateTimeText)
                ]),
                        ),
              ),
            ),
          )
      ]),
    );
  }
}
