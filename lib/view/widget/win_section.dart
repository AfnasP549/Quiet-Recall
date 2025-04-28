import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiet_recall/core/constants/app_color.dart';
import 'package:quiet_recall/view_model/game_view_model.dart';

class WinSection extends StatelessWidget {
  const WinSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameViewModel>(
      builder: (context, viewModel, child) {
        if (!viewModel.gameWon) return const SizedBox.shrink(); // Hide if not won
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              //!winning time
              Text(
                'You Won! Time: ${viewModel.formatTime(viewModel.elapsedTime)}',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 22),
              ElevatedButton(
                onPressed: () {
                  viewModel.resetGame();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.repeat_rounded,
                        color: AppColor.iconSecondaryColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Play Again',
                        style: TextStyle(
                          color: AppColor.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}