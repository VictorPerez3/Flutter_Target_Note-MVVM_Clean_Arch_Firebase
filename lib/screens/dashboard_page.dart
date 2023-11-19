import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../components/general/background_box_decoration.dart';
import '../components/dashboard/dashboard_icon_button.dart';
import '../components/dashboard/dashboard_text_field.dart';
import '../components/general/privacy_policy_label.dart';
import '../stores/dashboard_store/dashboard_store.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardStore store = DashboardStore();
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundBoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Observer(
                    builder: (_) => ListView.separated(
                      padding: const EdgeInsets.only(top: 10),
                      itemCount: store.items.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = store.items[index];
                        return ListTile(
                          title: Text(
                            item.text,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: focusNode.hasFocus
                              ? null
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    DashboardIconButton(
                                        iconButtonAction: IconButtonAction.edit,
                                        iconColor: Colors.black,
                                        icon: Icons.edit,
                                        focusNode: focusNode,
                                        textEditingController:
                                            textEditingController,
                                        item: item,
                                        store: store),
                                    DashboardIconButton(
                                        iconButtonAction:
                                            IconButtonAction.delete,
                                        iconColor: Colors.red,
                                        icon: Icons.cancel,
                                        focusNode: focusNode,
                                        textEditingController:
                                            textEditingController,
                                        item: item,
                                        store: store),
                                  ],
                                ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              DashboardTextField(
                  textEditingController: textEditingController,
                  focusNode: focusNode,
                  store: store),
              const SizedBox(height: 70),
              Observer(
                  builder: (_) => PrivacyPolicyLabel(
                        isActive: focusNode.hasFocus,
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
