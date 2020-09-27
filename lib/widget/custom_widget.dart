import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundSearchBar extends StatelessWidget {
  final TextEditingController txtController;
  final String label;
  final String initialText;
  final double width;
  final IconData prefixIcon;
  final Color prefixIconColor;
  final Function iconTap;
  final Function onSubmitted;
  final double height;

  RoundSearchBar(
      {@required this.txtController,
      this.label,
      this.initialText,
      this.width,
      this.prefixIcon,
      this.height,
      this.prefixIconColor, this.iconTap, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Material(
        borderRadius: BorderRadius.circular(25),
        elevation: 0.1,
        child: ListTile(
          leading: IconButton(
            icon: Icon(prefixIcon == null ? Icons.search : prefixIcon),
            color: prefixIconColor == null ? Colors.black12 : prefixIconColor,
            onPressed:iconTap,
          ),
          title: TextField(
            /*expands: true,maxLines: null,minLines: null,*/
            style: TextStyle(fontSize: 13),
            controller: txtController /*..text = initialText*/,
            decoration: InputDecoration(
//            labelText: label,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 2/*, bottom: 11, top: 15*/, right: 2),
                hintText: label),
//        onChanged: ,
        onSubmitted:onSubmitted,
//        onEditingComplete: ,
          ),
        ),
      ),
    );
  }
}
