import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiet_recall/core/constants/app_color.dart'; // Adjust path
import 'package:quiet_recall/core/widget/custom_appbar.dart'; // Adjust path
import 'package:quiet_recall/view_model/game_view_model.dart'; // Adjust path

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GameViewModel>(context, listen: false).startGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Consumer<GameViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(25)),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(16.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                        duration: Duration(milliseconds: 300),
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
                                  style: TextStyle(fontSize: 40),
                                )
                              : Icon(
                                  Icons.question_mark,
                                  size: 40,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColor.secondaryColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.access_time_filled,
                      color: AppColor.iconPrimaryColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      viewModel.formatTime(viewModel.elapsedTime),
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22),
              Text(
                'High Score: ${viewModel.bestTime != null ? viewModel.formatTime(viewModel.bestTime!) : "N/A"}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 22),
              if (viewModel.gameWon)
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'You Won! Time: ${viewModel.formatTime(viewModel.elapsedTime)}',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 22),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.resetGame();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.repeat_rounded, color: AppColor.iconSecondaryColor),
                            SizedBox(width: 10),
                            Text(
                              'Play Again',
                              style: TextStyle(color: AppColor.textSecondaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}