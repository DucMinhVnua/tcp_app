import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarWidget extends StatelessWidget {
  double value;
  Function(double) onCountChange;

  RatingBarWidget({this.value, @required this.onCountChange});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        // custom gì thì custom hết ở đây
        initialRating: this.value,
        glow: false,
        minRating: 1,
        direction: Axis.horizontal,
        itemBuilder: (context, index) {
          return Icon(
            Icons.star,
            color: Colors.amber,
            size: 20,
          );
        },
        onRatingUpdate: (rating) {
          onCountChange(rating);
        });
  }
}
