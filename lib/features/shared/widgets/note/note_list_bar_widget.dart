import 'package:flutter/material.dart';

class NoteListBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleUserInfoName;
  final VoidCallback onLogout;

  const NoteListBar({
    super.key,
    required this.titleUserInfoName,
    required this.onLogout,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1C1B1F),
      elevation: 0,
      leading: const Padding(
        padding: EdgeInsets.only(left: 12.0),
        child: Icon(
          Icons.account_circle,
          color: Color(0xFF49454F),
          size: 36,
        ),
      ),
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          titleUserInfoName,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.25,
            color: Color(0xFF79747E),
          ),
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          padding: const EdgeInsets.only(right: 12.0),
          icon: const Icon(
            Icons.logout,
            color: Color(0xFFD0BCFF),
            size: 22,
          ),
          onPressed: onLogout,
        ),
      ],
    );
  }
}
