import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiet_recall/view_model/game_view_model.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80, // 👈 custom height
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Image.asset('asset/logo.png', height: 50), // Adjust logo height
      ),
      centerTitle: true,
      actions: [
        Consumer<GameViewModel>(
          builder: (context, viewModel, _) => IconButton(
            onPressed: () => viewModel.resetGame(),
            icon: const Icon(Icons.refresh, size: 30), // optional: bigger icon
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80); // 👈 same as toolbarHeight
}
