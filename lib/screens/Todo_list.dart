import 'package:flutter/material.dart';
import 'package:leo_todo_app/screens/Todo_Detail.dart';


class Todolist extends StatefulWidget {
  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  int count=1;//count for list size 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:Text("Leo_Todo_App"),
          centerTitle: true,
          ),
           drawer: Drawer(
             child: UserAccountsDrawerHeader(accountName:Text("uzairleo") 
             , accountEmail: Text("Uzair.jan336@gmail.com"),
              )
             ,
             elevation: 3.0,
              ),
              floatingActionButton: FloatingActionButton(
                tooltip: "add new note",
                child: Icon(Icons.add),
                onPressed: ()
                {
                  Navigator.push(context,MaterialPageRoute(
                    builder: (BuildContext context)=> (TodoDetail())
                  ));
                },
              ),
              body:todoBody(),
              );
  }
  ListView todoBody()
  {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context,index)
      {
        return Card(
            elevation:  4.0,
             child: ListTile(
               leading:CircleAvatar(
                 child:Icon(Icons.keyboard_arrow_right),
                 backgroundColor: Colors.yellow,
               ),
               title: Text("dummy title"),
               subtitle: Text("dummy subtitle"),
               trailing: IconButton(
                 icon: Icon(Icons.delete), 
                 onPressed: (){
                navigateToNextScreen();
                 })
                 ),
             
        );
      }
    );
  }

navigateToNextScreen()
{
     Navigator.push(context,
                   MaterialPageRoute(
                     builder:(BuildContext context )
                     {
                       return TodoDetail();
                     }
                   ));
                
}
}