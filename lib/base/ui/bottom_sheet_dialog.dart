import 'package:flutter/material.dart';
import 'package:workflow_manager/base/utils/common_function.dart';
import 'package:workflow_manager/base/extension/string.dart';
import 'package:workflow_manager/tpc/models/response/pair_reponse.dart';

class BottomSheetDialog {
  BuildContext context;

  String title;

  Function(dynamic) onTapListener;

  BottomSheetDialog({@required this.context, this.title, this.onTapListener});

  // data truyền vào phải là một list object có key là value
  Future<dynamic> showBottomSheetDialog(data) async {
    if (isNullOrEmpty(data)) return null;
    return await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (ctx) {
          return SizedBox(
            height: data.length * 80.0,
            child: Container(
              color: Colors.white,
              child: ListView.separated(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(child: Text(data[index].value, style: TextStyle(fontSize: 14),)),
                          Visibility(
                            visible: data[index].isSelected ?? false,
                            child: Icon(Icons.check, color: Colors.blue,),
                          )
                        ],
                      ),
                    ),
                    onTap: () async {
                      if (this.onTapListener != null) {
                        for (int i = 0; i < data.length; i++) {
                          if (data[index].key == data[i].key) {
                            if (data[i].isSelected == true) {
                              data[i].isSelected = false;
                            } else {
                              data[i].isSelected = true;
                            }
                          } else {
                            data[i].isSelected = false;
                          }
                        }
                        var result = await this.onTapListener(data[index]);
                        Navigator.pop(context, result);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            ),
          );
        });
  }

  Future<dynamic> showBottomSheetDialogWithCheckIcon(data,
      {IconData icon1, IconData icon2}) async {
    if (isNullOrEmpty(data)) return null;
    return await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (ctx) {
          return BottomSheetWidget(title, data, this.onTapListener,
              icon1: icon1, icon2: icon2);
        });
  }
}

class BottomSheetWidget extends StatefulWidget {
  var data = List();

  String title;

  Function(dynamic) onTapListener;

  IconData icon1;

  IconData icon2;

  BottomSheetWidget(this.title, this.data, this.onTapListener,
      {this.icon1, this.icon2});

  @override
  State<StatefulWidget> createState() {
    return BottomSheetState();
  }
}

class BottomSheetState extends State<BottomSheetWidget> {
  IconData checkDisplayIcon(Pair pair) {
    if (widget.icon1 == null || widget.icon2 == null) {
      if (pair.selectType != null) {
        return Icons.check;
      } else {
        return null;
      }
    }
    if (pair.selectType != null) {
      if (pair.selectType == 1) {
        return widget.icon2;
      } else {
        return widget.icon1;
      }
    }
    return null;
  }

  changeStatusIcon(int index) {
    if (widget.data[index].selectType == null ||
        widget.data[index].selectType == 0) {
      widget.data[index].selectType = 1;
    } else {
      widget.data[index].selectType = 0;
    }
    for (var i = 0; i < widget.data.length; i++) {
      if (i != index) {
        widget.data[i].selectType = null;
      }
    }
  }

  _listData() {
    return SafeArea(
      bottom: true,
      child: ListView.separated(
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: ListTile(
              title: Text(
                widget.data[index].value,
                style: TextStyle(fontSize: 14),
              ),
              trailing: Icon(
                checkDisplayIcon(widget.data[index]),
                color: Colors.blue,
              ),
            ),
            onTap: () async {
              setState(() {
                changeStatusIcon(index);
              });
              if (widget.onTapListener != null) {
                var result = await widget.onTapListener(widget.data[index]);
                Navigator.pop(context, result);
              } else {
                Navigator.pop(context);
              }
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isNotNullOrEmpty(widget.title)
          ? widget.data.length * 80.0 + 40
          : widget.data.length * 80.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        child: isNotNullOrEmpty(widget.title)
            ? Column(
                children: [
                  Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        widget.title,
                        style: TextStyle(fontSize: 16),
                      )),
                  Divider(color: "E9ECEF".toColor()),
                  Expanded(
                    child: _listData(),
                  ),
                ],
              )
            : _listData(),
      ),
    );
  }
}
