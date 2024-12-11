import 'package:flutter/material.dart';

import '../../../../core/base/mixins/l18n_mixin.dart';
import '../../../../core/resources/note/domain/constants/note_types_and_hide_constants.dart';

abstract class MenuSize {
  static const double menuHeight = 184;
}

class MenuItemList extends StatelessWidget with l18nMixin {
  final VoidCallback onDelete;
  final VoidCallback onDuplicate;
  final VoidCallback onHide;
  final VoidCallback onUnhide;
  final String noteTypeMode;

  const MenuItemList(
      {super.key,
      required this.onDelete,
      required this.onDuplicate,
      required this.onHide,
      required this.onUnhide,
      required this.noteTypeMode});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF25232a),
      child: SizedBox(
        width: 200,
        height: MenuSize.menuHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildMenuButton(
                  label: l18n.strings.notePage.deleteMenuLabel,
                  onTap: onDelete),
              _buildMenuButton(
                  label: l18n.strings.notePage.duplicateMenuLabel,
                  onTap: onDuplicate),
              if (noteTypeMode == NoteTypesAndHideConstants.hiddenNotes)
                _buildMenuButton(
                  label: l18n.strings.notePage.unhideMenuLabel,
                  onTap: onUnhide,
                )
              else
                _buildMenuButton(
                  label: l18n.strings.notePage.hideMenuLabel,
                  onTap: onHide,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
      {required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white12,
      highlightColor: Colors.white10,
      child: Container(
        width: 200,
        height: 56,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFFE6E1E5),
              fontFamily: 'Roboto',
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
