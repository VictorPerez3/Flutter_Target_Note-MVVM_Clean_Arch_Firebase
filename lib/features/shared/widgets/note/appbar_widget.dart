import 'package:flutter/material.dart';

import '../../../../core/base/constants/general_string.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogout;

  const CustomAppBar({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.logout),
        onPressed: onLogout,
      ),
      title: const Text(GeneralConstants.strAppBarLabel),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
