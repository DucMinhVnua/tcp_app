import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workflow_manager/common/constants/colors.dart';
import 'package:workflow_manager/common/constants/styles.dart';

class AddButton extends StatelessWidget {

  final Function onTapButton;

  AddButton({this.onTapButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: TextButton(
        child: Row(
          children: [
            Text(
              'THÊM',
              style: kDefaultTextStyle.copyWith(color: kBlue1, fontWeight: FontWeight.w500, fontSize: 13.0),
            ),
            SizedBox(width: 3.0),
            Icon(Icons.add_rounded, color: kBlue1, size: 15.0,)
          ],
        ),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: kBlue1),
              borderRadius: BorderRadius.circular(8.0)
          ),
          padding: EdgeInsets.zero,
          minimumSize: Size(70.0, 25.0),
        ),
        onPressed: onTapButton,
      ),
    );
  }
}
