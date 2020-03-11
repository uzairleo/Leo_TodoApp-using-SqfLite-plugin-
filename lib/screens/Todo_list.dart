import 'package:flutter/material.dart';
import 'package:leo_todo_app/screens/Todo_Detail.dart';
import 'dart:async';
import 'package:leo_todo_app/Models/Note.dart';
import 'package:leo_todo_app/Utils/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class Todolist extends StatefulWidget {
  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  int count=0;//count for list size 

  DatabaseHelper databaseHelper=DatabaseHelper();
  List<Note> notelist;
  @override
  Widget build(BuildContext context)
   {
    if(notelist==null)
    {
      notelist=List<Note>();
      updateListview();
    }
    return Scaffold(
      appBar: AppBar(
        title:Text("Leo_Todo_App"),
        centerTitle: true,
          ),
           drawer: Drawer(
             child: Column(
                children: <Widget>[
                  Container(
                    height:300,
                    color:Colors.deepPurple,
                    child:Center(
                      child: Icon(Icons.tag_faces,size: 200,color:Colors.white60),
                    ),
                  )
                ],
             )
             ,
             elevation: 3.0,
              ),
              floatingActionButton: FloatingActionButton(
                tooltip: "add new note",
                child: Icon(Icons.add),
                onPressed: ()
                {
                  navigateToNextScreen(Note('','',2),appBar: "Add Note");
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
        return  Card(
              elevation:  4.0,
               child: InkWell(
                 onTap: (){
                   print(index);
                  navigateToNextScreen(this.notelist[index],appBar: "Edit Note");
                    },
                                child: ListTile(
                   leading:CircleAvatar(
                     child:getPriorityIcon(this.notelist[index].getPriorities),
                     backgroundColor: getPriorityColor(this.notelist[index].getPriorities),
                   ),
                   title:Text( this.notelist[index].getTitle),
                   subtitle: Text( this.notelist[index].getDate),
                   trailing: IconButton(
                     icon: Icon(Icons.delete), 
                     onPressed: (){
                    //deleteButtonLogic Here
                    delete(context, notelist[index]);
                     })
                     ),
               ),
        );
      }
    );
  }
 Icon getPriorityIcon(int priorityicon)
  {
    switch(priorityicon)
    {
      case 1:
      return Icon(Icons.play_arrow);    break;
      case 2:
      return Icon(Icons.keyboard_arrow_right);
  
      break;

    default:
        return Icon(Icons.keyboard_arrow_right);
    }

  }

  Color getPriorityColor(int priorityColor)
  {
      switch(priorityColor)
      {
        case 1: 
        return Colors.orange;
        break;
        case 2:
        return Colors.yellow;
        break;
        default:
        return Colors.yellow;
      }
  }
  delete(BuildContext context,Note note)async
  {
      int result= await DatabaseHelper().deleteNote(note.getId);//delete from database
      if(result!=0)
      {
        showSnackbar(context,"Your Note is deleted successfully");
        updateListview();//it will remove the listile from the screen as well
      }
  }
  showSnackbar(BuildContext context,String title)
  {
    var snackbar=SnackBar(content: Text(title),);
      Scaffold.of(context).showSnackBar(snackbar);
  }

navigateToNextScreen(Note note,{String appBar})
async{
   bool result=await  Navigator.push(context,
                   MaterialPageRoute(
                     builder:(BuildContext context )
                     {
                       return TodoDetail(note,appBar);
                     }
                   ));
    if(result==true)
    {
      updateListview();
    }
                
}

updateListview()//it will update ui/screen after each operation
{
   final Future<Database> dbFuture= databaseHelper.initializedDatabase();
   dbFuture.then((database){

    Future< List<Note>> noteListFuture=databaseHelper.getNoteList();
     noteListFuture.then((notelist){
        setState(() {
      print (this.count);
          this.notelist=notelist;
          this.count=notelist.length;//here is the brain of ListItems count
        });//here the count will increase each time this updateListview method called
     });
   });
   }

}
