import 'package:tp/models/meal.dart';
import 'package:hive/hive.dart';
part 'day_meals.g.dart';

@HiveType(typeId: 0)
class DayMeals {
  @HiveField(0, defaultValue: "")
  String? day;
  @HiveField(1, defaultValue: "")
  List<Meal>? listOfMeals;
  DayMeals({this.day, this.listOfMeals});
}
