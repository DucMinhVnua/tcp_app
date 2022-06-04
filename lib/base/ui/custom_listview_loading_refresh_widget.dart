import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:workflow_manager/base/ui/empty_screen.dart';

class CustomListViewWidget extends StatelessWidget {
  final void Function() onRefresh;
  final void Function() onLoading;
  Widget listViewWidget;
  int lengthList;
  String textEmpty;

  CustomListViewWidget(
      {this.onRefresh,
      this.onLoading,
      this.listViewWidget,
      this.lengthList,
      this.textEmpty});

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      // header: false không cho refresh true cho fresh
      enablePullDown: onRefresh == null ? false : true,
      // footer: false không cho loading true cho loading
      enablePullUp: onLoading == null ? false : true,
      header: WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
          } else if (mode == LoadStatus.canLoading) {
          } else {}
          return Container(
            height: 55.0,
            child: Center(
              child: body,
            ),
          );
        },
      ),
      controller: _refreshController,
      onLoading: () {
        this._refreshController.loadComplete();
        onLoading();
      },
      onRefresh: () {
        this._refreshController.refreshCompleted();
        onRefresh();
      },
      child: lengthList == null || lengthList == 0
          ? EmptyScreen(
              message: textEmpty ?? 'Không có dữ liệu!',
            )
          : listViewWidget,
    );
  }
}
