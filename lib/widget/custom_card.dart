import 'package:flutter/material.dart';
import 'package:untitled2/screen/news_screen.dart';
import '../Colors/colors.dart';

class CustomCard extends StatefulWidget {
  final Icon icon;
  final String section;
  final bool isSelected;
  final void Function (bool isSelected, String section) onSelected;

  const CustomCard({
    super.key,
    required this.icon,
    required this.section,
    this.isSelected = false,
    required this.onSelected,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
   bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onSelected(isSelected, widget.section);
      },
      child: Card(
        color: isSelected ? primaryColor : Colors.blue.shade100,
        shadowColor: blackColor,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon,
            Text(
              widget.section,
              style: TextStyle(color: blackColor),
            ),
          ],
        ),
      ),
    );
  }
}

