
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiet_recall/core/widget/custom_appbar.dart';
import 'package:quiet_recall/view/widget/game_timer.dart';
import 'package:quiet_recall/view_model/game_view_model.dart';
import 'package:quiet_recall/view/widget/card_grid.dart'; 
import 'package:quiet_recall/view/widget/win_section.dart'; 

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
              const Padding(padding: EdgeInsets.all(25)),
              const Expanded(child: CardGrid()), //!card 
              GameTimer(time: viewModel.formatTime(viewModel.elapsedTime)),
              const SizedBox(height: 22),
              //!high score
              Text(
                'High Score: ${viewModel.bestTime != null ? viewModel.formatTime(viewModel.bestTime!) : "N/A"}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 22),
              const WinSection(), //!winning 
            ],
          );
        },
      ),
    );
  }
}
