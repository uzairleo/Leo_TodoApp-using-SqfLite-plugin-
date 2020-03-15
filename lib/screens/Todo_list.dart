import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:leo_todo_app/screens/Todo_Detail.dart';
import 'dart:async';
import 'package:leo_todo_app/Models/Note.dart';
import 'package:leo_todo_app/Utils/DatabaseHelper.dart';
import 'package:leo_todo_app/screens/UserLogin.dart';
import 'package:leo_todo_app/screens/userSetting.dart';
import 'package:sqflite/sqflite.dart';

class Todolist extends StatefulWidget {
  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  int count=0;//count for list size 

  DatabaseHelper databaseHelper=DatabaseHelper();
  String day=DateFormat.d().format(DateTime.now());
  String month=DateFormat.MMMM().format(DateTime.now());
  String year=DateFormat.y().format(DateTime.now());
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
      
              bottomNavigationBar: BottomAppBar(
                color:Colors.blue,
                shape:CircularNotchedRectangle(),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon:Icon(FontAwesomeIcons.user),
                      color: Colors.white, 
                      onPressed: (){
                       navigateToUser(nameOfPage: "userlogin");
                      }),
                    
                    IconButton(
                      icon:Icon(Icons.search),
                      color: Colors.white, 
                      onPressed: (){
                        navigateToUser(nameOfPage: "usersetting");
                      }),
                    
                  ],)
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                tooltip: "add new note",
                child: Icon(Icons.add),
                backgroundColor:  Color(0xff8d70fe),
                onPressed: ()
                {
                  navigateToNextScreen(Note('','',2),appBar: "Add Note");
                },
              ),
              body:Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                    children: <Widget>[
                      Positioned(child: Container(
                        width:MediaQuery.of(context).size.width,
                        height:MediaQuery.of(context).size.height/3,
                        decoration:BoxDecoration(
                          color: Color(0xff5a348b),
                          gradient: LinearGradient(
                            colors: [Color(0xff8d70fe),Color(0xff2da9ef)],
                            begin:Alignment.centerRight,
                            end: Alignment(-1.0,-1.0),
                            )
                        ),
                        child:_dateContent(),
                      )),
                    Positioned(
                      top: 160,
                      left: 18.0,
                      right: 18.0,
                     child: Container(
                       width: 380,
                       decoration: BoxDecoration(
                         color: Colors.white,
                        boxShadow: [
                      BoxShadow(
                       color: Colors.black12,
                       blurRadius: 25.0, // soften the shadow
                       spreadRadius: 5.0, //extend the shadow
                       offset: Offset(
                         15.0, // Move to right 10  horizontally
                         15.0, // Move to bottom 10 Vertically
                        ),
                        )
                        ],
                       ),
                       height: MediaQuery.of(context).size.height/1.5,
                        child:  todoBody(),
                     ),)  
                    
                    ],
                ),
              ),
              );
  }
  Widget _dateContent()
  {
    return Align(
                child: ListTile(
                leading:Text(day,style:TextStyle(fontSize: 50.0,color:Colors.amber)),
                title: Text(month,style:TextStyle(fontSize: 34.0,color:Colors.white)),
                 subtitle: Text(year,style:TextStyle(fontSize: 24.0,color:Colors.white)),
                          ),
                        ); 
  }
  ListView todoBody()
  {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context,index)
      {
        return  Padding(
          padding: const EdgeInsets.only(left: 20.0,right:20.0,bottom: 10.0),
          child: Dismissible(
                    key: Key(notelist[index].toString()),
background: myHiddenContainer(getPriorityColor(this.notelist[index].getPriorities)),
                  onDismissed: (directions){
                      if(directions==DismissDirection.startToEnd)
                      {
                            // delete(context, notelist[index]);
                      }else
                      if(directions==DismissDirection.endToStart)
                      {

                            delete(context, notelist[index]);
                      }
                  },
                      child: Card(
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
                        // delete(context, notelist[index]);
                         })
                         ),
                   ),
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

   navigateToUser({nameOfPage})
  {
    if(nameOfPage=="userLogin"||nameOfPage=="userlogin")
    {

      Navigator.push(context, 
      MaterialPageRoute(
        builder:(context)=> (UserLogin())
      ));
    }else 
    if(nameOfPage=="UserSetting"||nameOfPage=="usersetting")
    {

      Navigator.push(context, 
      MaterialPageRoute(
        builder:(context)=> (UserSetting())
      ));

    }else
    {
      print("Plz write the route name perfectly");
    }

  }
Widget myHiddenContainer(Color noteColor)
{
return Container(
  height: MediaQuery.of(context).size.height,
  color: noteColor,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      // Align(
      //   alignment: Alignment.centerLeft,
      //   child:IconButton(
      //     icon:null,
      //      onPressed: (){

      //      })
      // ),
       Align(
        alignment: Alignment.centerRight,
        child:IconButton(
          icon: Icon(FontAwesomeIcons.solidTrashAlt),
           onPressed: (){

           })
      )

    ],
  ),
);

}

}
