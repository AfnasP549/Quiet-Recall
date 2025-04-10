import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiet_recall/core/constants/app_color.dart';
import 'package:quiet_recall/view/game.dart';
import 'package:quiet_recall/view_model/game_view_model.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});



  @override
  Widget build(BuildContext context) {

    return Scaffold(
    //  backgroundColor: Colors.blue, // Match the game theme
      body: Consumer<GameViewModel>(
        builder: (context, viewModel, _) {
          
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Game Logo/Image
              Image.asset(
                'asset/applogo.png',
                width: 380,
                height: 600,
              ),
              SizedBox(height: 40),
              // High Score Display
              Text(
                'High Score: ${viewModel.bestTime != null ? viewModel.formatTime(viewModel.bestTime!) : "N/A"}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              // Start Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Game()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: TextStyle(fontSize: 20),
                ),
                child: Text('Start',style: TextStyle(color: AppColor.textSecondaryColor),),
              ),
            ],
          ),
        );
        },
      ),
    );
  }
}