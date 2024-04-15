import 'package:flutter/material.dart';
import 'package:tp/models/meal.dart';

class IngrediantPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final receivedData = ModalRoute.of(context)?.settings.arguments as Meal;
    print(receivedData.listOfIngredient![0]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingrediant list for ' '${receivedData.name} ' 'meal'),
      ),
      body: ListView.builder(
        itemCount: receivedData.listOfIngredient!.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(8)),
                child: Text('${index + 1}'
                    ':'
                    '${receivedData.listOfIngredient![index]}'),
              ),
              const SizedBox(
                height: 15,
              )
            ],
          );
        },
      ),
    );
  }
}
