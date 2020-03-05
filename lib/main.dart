import 'package:flutter/material.dart';
import 'package:leo_todo_app/screens/Todo_list.dart';

void main()
{
  runApp(new MyTodoApp());
}
class MyTodoApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      title: 'Leo_Todo_App',
      home: Scaffold(
        body:SplashScreen()
      ),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }  
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() { 
    super.initState();
    Future.delayed(
      Duration(
        seconds: 5,
        ),
    (){
      Navigator.push(context,MaterialPageRoute
      (
        builder:(context)=>(Todolist()))
        );
    }
    );
  
  }
  @override
  Widget build(BuildContext context) {
    return Container(
    alignment: Alignment.center,
    color: Colors.deepPurple,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget>
      [
        Padding(padding: const EdgeInsets.only(top: 150),
        child: CircleAvatar(
          radius: 60,
          backgroundColor: Colors.orange,
          child: CircleAvatar(
            backgroundColor: Colors.pink,
          radius: 55,
          child: Icon(Icons.note_add,size: 50,color: Colors.grey,),
          ),
        ),
        ),
        Padding(padding: const EdgeInsets.only(top: 20.0),
        child:Text("Leo Todo",
        style: TextStyle(
          fontSize: 40,
          fontWeight:FontWeight.bold,
          color: Colors.grey,
        ),)),
        Padding(padding: const EdgeInsets.only(top: 100,bottom: 10),
        child: CircularProgressIndicator(backgroundColor: Colors.white60,),),
        Padding(padding: const EdgeInsets.only(top: 80.0),
        child:Text("Version 1.0",style: TextStyle(
          fontSize: 12.0,
          color:Colors.white54,
        ),)
        )

      ]
    ),
  );  }
}
 
