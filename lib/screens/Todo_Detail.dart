// import 'dart:ffi';

import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:leo_todo_app/Models/Note.dart';
import 'package:leo_todo_app/Utils/DatabaseHelper.dart';
import 'package:leo_todo_app/screens/TodoDetail_Dilogue.dart';
import 'package:leo_todo_app/screens/Todo_list.dart';
// import 'package:leo_todo_app/screens/Todo_list.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TodoDetail extends StatefulWidget {
  final Note note;
 final String appBartitle;
      TodoDetail(this.note,this.appBartitle);
   @override
  _TodoDetailState createState() => _TodoDetailState(this.note,appBartitle);
}

class _TodoDetailState extends State<TodoDetail> {
 DatabaseHelper helper=DatabaseHelper();
  Note note;
 static var _priorities=["High","Low"];
 String appBartitle;
//  int result;
 TextEditingController titleController=TextEditingController();
TextEditingController discriptionController=TextEditingController();
 _TodoDetailState(this.note,this.appBartitle);
 
  @override
  Widget build(BuildContext context) {
    titleController.text=note.getTitle;
    discriptionController.text=note.getDiscription;
    var textStyle=Theme.of(context).textTheme.title;  
        return
        Scaffold(
          appBar: AppBar(
          title: Text(appBartitle),

      
      ),
    body:

     Padding(
      padding: const EdgeInsets.only(top:10.0,left:8.0,right:8.0),
      child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>
          [
            //first element will be a drop down that will select priorities for all these todo notes
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: DropdownButton(
                items:_priorities.map((String dropDownItem){
                  return DropdownMenuItem(
                    value: dropDownItem,
                    child:Text(dropDownItem),
                    );
                }).toList(),
                style: textStyle,
                value: getPriorityAsString(note.getPriorities),
                onChanged:(valuechange)
                {
                  setState(() {
                     print("done");
                    updatePriorityAsInteger(valuechange);
                  });

                }
                 ),
            ),
          //second element title textFiel
           Padding(
             padding: const EdgeInsets.only(top:8.0),
             child: TextFormField(
               style: textStyle,
               controller: titleController,
               onChanged: (value){
                //  if(titleController.text.toString()==null)
                 updateTitle();
               },
                decoration: InputDecoration(
              labelStyle: textStyle,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
  ),
  labelText: "Title",
  
),
              ),
           ),
      
          //third element discription textfield 
       Padding(
           padding: const EdgeInsets.only(top:10.0),
           child: TextFormField(
             onChanged: (value){
               updateDiscription();
             },
             controller: discriptionController,
             style: textStyle,
             decoration: InputDecoration(
               labelStyle: textStyle,
               border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(6.0),
               ),
               labelText: "Discription" 
             ),
            
           ),
       ) ,
          //fourth element row of Buttons
      Padding(
          
          padding: const EdgeInsets.only(top:8.0),
          child: Row(
            children: <Widget>[
           Expanded(child: RaisedButton(
          
                onPressed: (){
                    setState(() {
                      if(titleController.text.toString()!=""&& discriptionController.text!="")
                      {
                         _save();
                      }else{
                        _showFancyDilogue(
                          title:"status", 
                          msg:"Please fill the title and discription first",
                          buttonText: 'OK',
                          alertType: AlertType.info,
                          bFunction: (){Navigator.pop(context);});
                      }

                    });
                },
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                elevation: 12.0,
                child:Text("Save",textScaleFactor: 1.5,),
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                ),),
                SizedBox(width:10),
                Expanded(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0),),
                    elevation: 12.0,
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    onPressed: (){
                      setState(() {
                      // moveToList();
                      setState(() {
                        _delete();
                      });

                      });
                    },
                    child:Text("Delete",textScaleFactor: 1.5,))),
            ],
          ),
      ),
      //  Padding(
      //    padding: const EdgeInsets.only(top:40.0,left: 20.0),
      //    child: Text("Result of two number is  $result")),
       
          ]
      ),
    ),
        );

  }
  moveToList()
  {
    // int countdb=await helper.getCount();
    // print('total count of objects we pushed to database == $countdb');
Navigator.pop(context,true);
  }
//convert string priority to integer priority 
void updatePriorityAsInteger(String priority)
{
  switch(priority)
  {
    case'High':
    note.setPriorities=1;
    break;
    case 'Low':
    note.setPriorities=2;
    break;
  }
}
String getPriorityAsString(int value)
{
  String priority;
  switch(value)
  {
    case 1:
    priority=_priorities[0];//High
    break;
    case 2:
    priority=_priorities[1];//Low

  }
  return priority;
}

updateTitle()
{
note.setTitle=titleController.text;
}

updateDiscription()
{
note.setDiscription=discriptionController.text;
}

//save your note to database
void _save()async
{
  // moveToList();
  note.setDate=DateFormat.yMMMd().format(DateTime.now());
  var result;
  if(note.getId!=null)
  {//case 1: update operation
      result= await helper.updateNote(note);

  }else{
    //case 2: Insert operation
      result= await helper.insertNote(note);
  }

  if(result!=null)
  {//success
    _showFancyDilogue(
    title:'Status',
    msg:'Your Note was saved successfully',
    buttonText: 'OK',
    alertType: AlertType.info,
    bFunction: (){
      Navigator.push(context,
      MaterialPageRoute(
        builder: (_)=> Todolist()
      ));
  // Navigator.of(context).pop();
    }
                      );
  }else
  {//failiure
   _showFancyDilogue(
     title:'Error',
     msg:'problem while saving your Note',
     buttonText:'Ok',
     alertType: AlertType.error ,
     bFunction: (){Navigator.pop(context);});
  }

}

// _showAlertDilogue(String status,String msg)
// {
//   var alertDilogue=AlertDialog(
// title: Text(status),
// content: Text(msg),
//   );
//   showDialog(context: context,
//   builder: (context)=>alertDilogue);
// }
_showFancyDilogue({String title,String msg,String buttonText,AlertType alertType,Function bFunction})
// async
{
//  await Future.delayed(Duration(seconds:2,),(){});
   
  Alert(context: context, 
  title:title,
  desc: msg,

  type: alertType,
   
  buttons: [
    DialogButton(
      child: Text(buttonText),
     onPressed: bFunction
    //  (){
    //   //  moveToList();
    //   Navigator.pop(context);
    //  }
     ),
  ],
  ).show();


}

//A function which delete note from database 
void _delete()async
{

// case 1: If user is trying to delete the New Note(i:e after coming to the detail page using FAB button)
if(note.getId==null)
{
  _showFancyDilogue(
    title:"status", 
    msg:"No note was deleted",
    buttonText: 'OK',
    alertType: AlertType.error,
    bFunction: (){Navigator.pop(context);},);
return ;
}

//case 2: if user wanna to delete the old note(i:e by pressing on ListTile in the list)
int result=await helper.deleteNote(note.getId);
if(result!=0)
{
  _showFancyDilogue(
    title:"Status",
    msg:"your Note was Deleted Successfully",
    buttonText: 'OK',
    alertType: AlertType.success,
    bFunction: (){

            Navigator.of(context).pop();
    
    });
}else{
  _showFancyDilogue(
    title:"status",
    msg:"Error Occured while deleting note",
    buttonText: 'OK',
    alertType: AlertType.error,
    bFunction: (){
      Navigator.of(context).pop();
    });
}
}
//convert integer priority to string priority 
  //  sum()
  // {
  //   int x=int.parse(titleController.text);
  //   int y=int.parse(discriptionController.text);
  //   int sum=x+y;
  //   return sum;
  // }
}