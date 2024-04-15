// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tp/models/day_meals.dart';
import 'package:tp/models/meal.dart';

class DayCard extends StatefulWidget {
  DayMeals? dayAndItsMealsList;
  final int index;

  DayCard({required this.dayAndItsMealsList, required this.index});

  @override
  State<DayCard> createState() => _DayCardState();
}

class _DayCardState extends State<DayCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.zero),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Center(
              child: Text(
                widget.dayAndItsMealsList!.day!,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'DetailsPage', arguments: [
                    Hive.box<DayMeals>('DayMeals').getAt(widget.index),
                    widget.index
                  ]);
                },
                child: const Icon(
                  Icons.visibility,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              InkWell(
                onTap: () async {
                  Meal? _meal =
                      await Navigator.pushNamed(context, 'AddMealPage')
                          as Meal?;
                  if (_meal != null) {
                    widget.dayAndItsMealsList!.listOfMeals!.add(_meal);
                    print('DAY meals:');
                    print(widget.dayAndItsMealsList!.listOfMeals!.length);
                    Hive.box<DayMeals>('DayMeals')
                        .putAt(widget.index, widget.dayAndItsMealsList!);
                  }
                },
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.black,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
