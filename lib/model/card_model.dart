// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'card_model.g.dart';

@HiveType(typeId: 0)
class CardModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  bool isFlipped;
  @HiveField(2)
  bool isMatched;


  CardModel({
    required this.id,
     this.isFlipped = false,
     this.isMatched = false,
  });


}
