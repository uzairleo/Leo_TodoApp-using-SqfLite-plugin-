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
    decoration: BoxDecoration(
       color: Color(0xff5a348b),
      gradient: LinearGradient(
        colors: [Color(0xff8d70fe),Color(0xff2da9ef)],
        begin:Alignment.centerRight,
        end:Alignment(-1.0,-1.0),
      )
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget>
      [
        Padding(padding: const EdgeInsets.only(top: 150),
        child: CircleAvatar(
          radius: 60,
          backgroundColor: Colors.amber,
          child: CircleAvatar(
            backgroundColor: Colors.pinkAccent,
          radius: 53,
          child: Icon(Icons.note_add,size: 55,color: Colors.grey,),

          ),
        ),
        ),
        Padding(padding: const EdgeInsets.only(top: 20.0),
        child:Text("Leo Todo",
        style: TextStyle(
          fontSize: 40,
          fontWeight:FontWeight.bold,
          color: Colors.white70,
        ),)),
        Padding(padding: const EdgeInsets.only(top: 100,bottom: 10),
        child: CircularProgressIndicator(backgroundColor: Colors.white60,),),
        Padding(padding: const EdgeInsets.only(top: 85.0),
        child:Text("Version 1.0",style: TextStyle(
          fontSize: 12.0,
          color:Colors.white60,
        ),)
        )

      ]
    ),
  );  }
}
 
