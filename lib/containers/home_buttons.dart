import 'package:flutter/material.dart';

class HomeButton extends StatefulWidget {
  String name;
  bool loading;
  VoidCallback onPress;
  HomeButton(
      {super.key,
      required this.name,
      this.loading = false,
      required this.onPress});

  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width * .42,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColor),
        child: Center(
          child: widget.loading
              ? CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                )
              : Text(
                  widget.name,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
        ),
      ),
    );
  }
}
