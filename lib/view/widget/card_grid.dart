import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiet_recall/core/constants/app_color.dart';
import 'package:quiet_recall/view_model/game_view_model.dart';

class CardGrid extends StatelessWidget {
  const CardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameViewModel>(
      builder: (context, viewModel, child) {
        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: viewModel.cards.length,
          itemBuilder: (context, index) {
            final card = viewModel.cards[index];
            return GestureDetector(
              onTap: () => viewModel.flipCard(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: viewModel.showAllCards || card.isFlipped || card.isMatched
                      ? AppColor.tertiaryColor
                      : AppColor.secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: viewModel.showAllCards || card.isFlipped || card.isMatched
                      ? Text(
                          card.id,
                          style: const TextStyle(fontSize: 40),
                        )
                      : const Icon(
                          Icons.question_mark,
                          size: 40,
                          color: Colors.white,
                        ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}