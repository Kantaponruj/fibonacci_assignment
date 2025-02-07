import 'package:fibonanci_assignment/utils/themes/custom_text_theme.dart';
import 'package:fibonanci_assignment/utils/themes/custom_theme.dart';
import 'package:flutter/material.dart';

enum NumberStatus {
  added,
  removed,
}

class ListViewComponent extends StatelessWidget {
  const ListViewComponent({
    super.key,
    required this.fibonacciNumbers,
    required this.onTap,
    required this.index,
    required this.trailing,
    this.status,
  });

  final int fibonacciNumbers;
  final int index;
  final void Function() onTap;
  final Widget trailing;
  final NumberStatus? status;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: key,
      tileColor: status != null
          ? status == NumberStatus.added
              ? greenBackgroundColor
              : redBackgroundColor
          : null,
      title: Text(
        "Index: #$index, Number: $fibonacciNumbers",
        style: bodyText(),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
