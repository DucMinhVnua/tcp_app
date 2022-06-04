// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:workflow_manager/tpc/models/day.dart';
//
// class DayOfWeekWidget extends StatefulWidget {
//
//   DayOfWeekWidget({this.day, this.onPressed});
//
//   final Day day;
//
//   final VoidCallback onPressed;
//
//   @override
//   State<StatefulWidget> createState() => _DayOfWeekWidgetState();
//
// }
// class _DayOfWeekWidgetState extends State<DayOfWeekWidget> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding (
//         padding: EdgeInsets.all(4),
//         child: RaisedButton (
//           textColor: Colors.white,
//           color: widget.day.status ? Colors.blue : Colors.grey,
//           padding: EdgeInsets.all(2),
//           child: Text(
//               widget.day.name,
//               style: TextStyle(color: Colors.white, fontSize: 9.0)
//           ),
//           onPressed: () => widget.onPressed(),
//           shape: new RoundedRectangleBorder(
//               borderRadius: new BorderRadius.circular(8.0)
//           ),
//         )
//     );
//   }
// }
