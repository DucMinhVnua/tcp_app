// import 'package:flutter/material.dart';
// import 'package:workflow_manager/base/extension/string.dart';
// import 'package:workflow_manager/base/ui/svg_image.dart';
//
// class InputCommentView extends StatelessWidget {
//
//   InputCommentView({this.text, this.onPress});
//
//   Function() onPress;
//
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Row(
//         children: [
//           SVGImage(svgName: 'icon_add'),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(left: 8, right: 8),
//               child: SizedBox (
//                 height: 40,
//                 child: TextField(
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(left: 16),
//                       hintText: this.text,
//                       hintStyle: TextStyle(color: Colors.grey),
//                       filled: true,
//                       fillColor: "F5F6FA".toColor(),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                         borderSide: BorderSide(color: Colors.white),
//                       )),
//                 ),
//               ),
//             ),
//           ),
//           SVGImage(svgName: 'icon_send', onTap: () {
//             onPress();
//           },),
//         ],
//       ),
//     );
//   }
// }
