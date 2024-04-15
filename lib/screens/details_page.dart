import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:tp/models/day_meals.dart';
import 'package:tp/models/meal.dart';

class DetailsPage extends StatefulWidget {
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final recivedData = ModalRoute.of(context)?.settings.arguments as List;
    final DayMeals dayMeals = recivedData.first as DayMeals;
    final int dayMealsIndex = recivedData.last as int;
    print(dayMeals.day);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details page',
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: GridView.builder(
        itemCount: dayMeals.listOfMeals!.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Card(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(dayMeals.listOfMeals![index].name!),
                const SizedBox(
                  height: 15,
                ),
                /*Image.asset(
                  myListofMeals[index].imgPath!,
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          //print('${myListofMeals[index].name}');
                          Navigator.pushNamed(context, 'Ingrediants_page',
                              arguments: dayMeals.listOfMeals![index]);
                        },
                        icon: const Icon(Icons.visibility)),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            dayMeals.listOfMeals!.removeAt(index);
                            Hive.box<DayMeals>('DayMeals')
                                .putAt(dayMealsIndex, dayMeals);
                          });
                        },
                        icon: const Icon(Icons.delete))
                  ],
                )
              ],
            ),
          ));
        },
      ),
    );
  }
}
