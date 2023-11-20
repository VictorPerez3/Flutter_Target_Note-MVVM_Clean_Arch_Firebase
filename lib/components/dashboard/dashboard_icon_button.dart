import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constants/dashboard/dashboard.string.dart';
import '../../stores/dashboard_store/dashboard_store.dart';

enum IconButtonAction {
  delete,
  edit
}

class DashboardIconButton extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final Item item;
  final DashboardStore store;
  final IconData icon;
  final Color iconColor;
  final IconButtonAction iconButtonAction;

  const DashboardIconButton({
    Key? key,
    required this.focusNode,
    required this.textEditingController,
    required this.item,
    required this.store,
    required this.icon,
    required this.iconColor,
    required this.iconButtonAction,
  }) : super(key: key);

  void removeToast() {
    Fluttertoast.showToast(
        msg: stringToastRemoveItem,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: iconColor),
      onPressed: () {
        if (!focusNode.hasFocus) {
          switch (iconButtonAction) {
            case IconButtonAction.edit:
              textEditingController.text = item.text;
              store.setEditingItem(item.id);
              focusNode.requestFocus();
              break;
            case IconButtonAction.delete:
              store.removeItem(item.id);
              removeToast();
              break;
          }
        }
      },
    );
  }
}
