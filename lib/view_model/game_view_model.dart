import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quiet_recall/model/card_model.dart';

class GameViewModel extends ChangeNotifier {
  List<CardModel> cards = [];
  int? firstFlippedIndex;
  int? secondFlippedIndex;
  bool isProcessing = false; //flippinf progress
  int matchedPairs = 0;
  int elapsedTime = 0;
  bool gameWon = false;
  int? bestTime;
  Timer? _timer;
  bool _isGameStarted = false;
  bool showAllCards = false;

  GameViewModel() {
    _initializeGame();
    _loadBestTime();
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  void _initializeGame() {
    List<String> emojiIds = ['⭐', '🍒', '🦋', '🎈', '🐾', '🌺', '🚀', '🧀'];
    List<String> cardIds = [...emojiIds, ...emojiIds];
    cardIds.shuffle();
    cards = cardIds.map((id) => CardModel(id: id)).toList();
    matchedPairs = 0;
    gameWon = false;
    elapsedTime = 0;
    firstFlippedIndex = null;
    secondFlippedIndex = null;
    isProcessing = false;
    _isGameStarted = false;
    showAllCards = false;
    notifyListeners();
  }

  void startGame() async {
    if (!_isGameStarted) {
      _isGameStarted = true;
      showAllCards = true; // Show all cards at the start
      notifyListeners();

      // Wait 5 seconds, then hide all cards and start the timer
      await Future.delayed(Duration(seconds: 5));
      showAllCards = false;
      for (var card in cards) {
        if (!card.isMatched) card.isFlipped = false; // onlly possible to flip non matched cards
      }
      _startTimer();   // timer started after preview
      notifyListeners();
    }
  }

  void flipCard(int index) async {//! for flipping two cards

    if (isProcessing || cards[index].isFlipped || cards[index].isMatched || !_isGameStarted || showAllCards) {//showallcards for during preview time
      return;
    } // prevent the card from flipping 

    if (firstFlippedIndex == null) {
      firstFlippedIndex = index;
      cards[index].isFlipped = true;
    } else if (secondFlippedIndex == null) {
      secondFlippedIndex = index;
      cards[index].isFlipped = true;
      isProcessing = true;
      notifyListeners();

      if (cards[firstFlippedIndex!].id == cards[secondFlippedIndex!].id) {
        cards[firstFlippedIndex!].isMatched = true;
        cards[secondFlippedIndex!].isMatched = true;
        matchedPairs++;
        if (matchedPairs == 8) {
          gameWon = true;
          _stopTimer();
          _saveBestTime();
        }
      }

      await Future.delayed(Duration(seconds: 1));
      _resetFlippedCards();
      isProcessing = false;
    }
    notifyListeners();
  }

  void _resetFlippedCards() {// reset the card
    if (firstFlippedIndex != null && secondFlippedIndex != null) {
      if (!cards[firstFlippedIndex!].isMatched) cards[firstFlippedIndex!].isFlipped = false;
      if (!cards[secondFlippedIndex!].isMatched) cards[secondFlippedIndex!].isFlipped = false;
    }
    firstFlippedIndex = null;
    secondFlippedIndex = null;
  }

  void _startTimer() {
    _stopTimer();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!gameWon && _isGameStarted) {
        elapsedTime++;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _loadBestTime() {
    final box = Hive.box('gameStats');
    bestTime = box.get('bestTime');
    notifyListeners();
  }

  void _saveBestTime() {
    final box = Hive.box('gameStats');
    final currentBest = box.get('bestTime');
    if (currentBest == null || elapsedTime < currentBest) {
      bestTime = elapsedTime;
      box.put('bestTime', elapsedTime);
      notifyListeners();
    }
  }

  void resetGame() async {//! play again
    _stopTimer();
    _initializeGame();
    _isGameStarted = true;
    showAllCards = true; // Show all cards again on reset
    notifyListeners();

    // Wait 5 seconds, then hide cards and start timer
    await Future.delayed(Duration(seconds: 5));
    showAllCards = false;
    for (var card in cards) {
      if (!card.isMatched) card.isFlipped = false;
    }
    _startTimer();
    notifyListeners();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}