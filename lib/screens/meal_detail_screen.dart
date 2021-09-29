import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName='meal_detail';
  final Function toggleFavorites;
    final Function isFavorites;
  MealDetailScreen(this.toggleFavorites,this.isFavorites);
  Widget buildSectionTitle(String text,context){
    return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(text,style: Theme.of(context).textTheme.title,),);        
  }
  Widget buildContainer(Widget child)=>Container(
            decoration: BoxDecoration(
               color: Colors.white,
              border: Border.all(color: Colors.grey),
             borderRadius: BorderRadius.circular(10)
            ),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            width: 300,
            height: 150,
            child: child
            );
  @override
  Widget build(BuildContext context) {
  final mealId=ModalRoute.of(context).settings.arguments as String;
  final selectedMeal=DUMMY_MEALS.firstWhere((meal) => meal.id==mealId);
    return Scaffold(
      appBar: AppBar(title: Text(selectedMeal.title),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width:double.infinity ,
            height: 300,
            child: Image.network(selectedMeal.imageUrl,fit: BoxFit.cover,),
            ),
           buildSectionTitle('ingredients', context),
           buildContainer( ListView.builder(
                physics: BouncingScrollPhysics(),
              itemBuilder:(context,index)=>Card(
                color: Theme.of(context).accentColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:5,horizontal:10),
                  child: Text(selectedMeal.ingredients[index]),
                ),
                ),
              itemCount:selectedMeal.ingredients.length ,
              ),),
              buildSectionTitle('steps', context),
              buildContainer( ListView.builder(
                physics: BouncingScrollPhysics(),
              itemBuilder:(context,index)=>Column(
                children:
               [
               ListTile(
                leading: CircleAvatar(child:Text('#${index+1}'),),
                title: Text(selectedMeal.steps[index]),),
                Divider(),
               ]
               ),

              itemCount:selectedMeal.steps.length ,
              ),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorites(mealId)?Icons.star:Icons.star_border,
        ),
        onPressed: ()=>toggleFavorites(mealId)
      ),
    );
  }
}