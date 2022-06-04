import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef _toggleView = void Function();

class AnimateContent extends StatefulWidget {
  Widget child;
  double _minHeight = 0;
  _toggleView __toggleView;

  bool expand = false;

  toggle() {
    if (__toggleView != null) __toggleView();
  }

  AnimateContent({Key key, this.child, double minHeight = -1, this.expand})
      : super(key: key) {
    if (minHeight != null) {
      _minHeight = minHeight;
    } else {
      // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   _minHeight = _state.context.findRenderObject().semanticBounds.height;
      // });
    }
  }

  @override
  _AnimateContentState createState() {
    return _AnimateContentState();
  }
}

class _AnimateContentState extends State<AnimateContent>
    with TickerProviderStateMixin {
  double _height;
  bool _isExpanded = false;
  GlobalKey _key = GlobalKey();
  AnimationController _controller;
  Animation<double> _animation;
  double _maxHeight = -1;

  toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      _height = _height > widget._minHeight ? widget._minHeight : 300;
      _height = _isExpanded ? 200 : 400;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(
    //   duration: const Duration(seconds: 3),
    //   vsync: this,
    // )..repeat();
    // _animation = CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.fastOutSlowIn,
    // );

    _height = widget._minHeight;
    widget.__toggleView = toggle;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_maxHeight == -1) {
        _maxHeight = _key.currentContext.size.height;
        boxConstraints = BoxConstraints(
            maxHeight: !widget.expand ? _maxHeight : widget._minHeight);
        setState(() {});
      }
    });
    prepareAnimations();
  }

  void prepareAnimations() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    Animation curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _animation = Tween(begin: widget._minHeight, end: _maxHeight).animate(curve)
      ..addListener(() {
        print("test nao ${_animation.value}");
        setState(() {});
      });
    _controller.animateTo(600);
  }

  BoxConstraints boxConstraints = BoxConstraints(maxHeight: double.infinity);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: Alignment.topCenter,
      curve: Curves.easeInToLinear,

      child: new Container(
        key: _key,
        constraints: boxConstraints,
        child: widget.child,
      ),
      vsync: this,
      duration: new Duration(seconds: 2),
      // vsync: this,
      // height: _height,
    );
  }
}
// class _ExpandedSectionState extends State<AnimateContent> with SingleTickerProviderStateMixin {
//   AnimationController expandController;
//   Animation<double> animation;
//
//   @override
//   void initState() {
//     super.initState();
//     prepareAnimations();
//   }
//
//   ///Setting up the animation
//   void prepareAnimations() {
//     expandController = AnimationController(
//         vsync: this,
//         duration: Duration(milliseconds: 500)
//     );
//     Animation curve = CurvedAnimation(
//       parent: expandController,
//       curve: Curves.fastOutSlowIn,
//     );
//     animation = Tween(begin: 0.5, end: 1.0).animate(curve)
//       ..addListener(() {
//         setState(() {
//
//         });
//       }
//       );
//   }
//
//   @override
//   void didUpdateWidget(AnimateContent oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if(widget.expand) {
//       expandController.forward();
//     }
//     else {
//       expandController.reverse();
//     }
//   }
//
//   @override
//   void dispose() {
//     expandController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizeTransition(
//         axisAlignment: 0.0,
//         sizeFactor: animation,
//         child: widget.child
//     );
//   }
// }
