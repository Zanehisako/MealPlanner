import 'package:hive/hive.dart';
part 'meal.g.dart';

@HiveType(typeId: 2)
class Meal {
  @HiveField(0, defaultValue: "")
  String? name;
  @HiveField(1, defaultValue: "")
  String? imgPath;
  @HiveField(2, defaultValue: [])
  List<String>? listOfIngredient;
  Meal({this.name, this.imgPath, this.listOfIngredient});
}
