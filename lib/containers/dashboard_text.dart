import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DashboardText extends StatefulWidget {
  String keyword, value;
  DashboardText({super.key, required this.keyword, required this.value});

  @override
  State<DashboardText> createState() => _DashboardTextState();
}

class _DashboardTextState extends State<DashboardText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("${widget.keyword} : ",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        Text(widget.value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
      ],
    );
  }
}
