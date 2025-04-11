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
      body: Consumer<GameViewModel>(
        builder: (context, viewModel, _) {
          
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'asset/applogo.png',
                  width: 380,
                  height: 380,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 40),
              // High Score
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
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  textStyle: TextStyle(fontSize: 20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Start',style: TextStyle(color: AppColor.textSecondaryColor),),
                ),
              ),
            ],
          ),
        );
        },
      ),
    );
  }
}