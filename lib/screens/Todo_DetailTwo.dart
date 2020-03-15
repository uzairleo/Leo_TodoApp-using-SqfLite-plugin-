

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leo_todo_app/Models/Note.dart';
import 'package:leo_todo_app/Utils/DatabaseHelper.dart';
import 'package:leo_todo_app/screens/Todo_list.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class Todo_DetailTwo extends StatefulWidget {
 final Note note;
 final String appBartitle;
Todo_DetailTwo(this.note,this.appBartitle);
  @override
  _Todo_DetailTwoState createState() => _Todo_DetailTwoState(note,appBartitle);
}

class _Todo_DetailTwoState extends State<Todo_DetailTwo> {
  DatabaseHelper helper=DatabaseHelper();
   String appBartitle;
   Note note;
  _Todo_DetailTwoState(this.note,this.appBartitle);
   
  static var _priorities=["High","Low"];
  var _myCustomStyle=TextStyle(color:Colors.black54);
  var titleController=TextEditingController();
  var discriptionController=TextEditingController();
  
   
  @override
  Widget build(BuildContext context) {
     titleController.text=note.getTitle;
    discriptionController.text=note.getDiscription;
   
    return myCustomDilogue();

  }

 Widget myCustomDilogue()
 {
   return AlertDialog(
        // shape: ,
        elevation: 2.0,
        title: Text("New task"),
        content: Container(
          height: 300,
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.only(top:8.0,left:4.0),
                 child:DropdownButton(
                   items: _priorities.map((dropdownitem){
                     return DropdownMenuItem(
                       value: dropdownitem,
                       child: Text(dropdownitem));
                   }).toList(), 

                   onChanged: (valuechange){
                     setState(() {
                       updatePriorityAsInteger(valuechange);
                     });
                   },
                   value: getPriorityAsString(note.getPriorities),
                   )),
                   Padding(padding: const EdgeInsets.only(top:8.0,left:40.0),
                   child:Text("OR"),),
                   Padding(padding: const EdgeInsets.only(top:5.0,left:20.0),
                   child:Row(children: <Widget>[
                    // IconButton(icon: Icon(FontAwesomeIcons.squareFull,color: Colors.yellow,), onPressed: (){}),
                    colorContainer(20.0, 20.0, Colors.yellow),
                    SizedBox(width:20.0),
                    colorContainer(20.0, 20.0, Colors.red)
                    
                   ],))
                    ],
                  ),
                  //basic date field
                  Padding(padding: const EdgeInsets.only(top:10.0,left:0.0),
                
                  child:DateTimeField(
                    decoration: InputDecoration(
                      hintText: "Date & time",
                      hintStyle: _myCustomStyle,
                    ),
                    format: DateFormat("yyyy-MM-dd HH:mm"), 
                    
                    onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),//checking for null pointer
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        }
                    //only time picker 
                  //   onShowPicker: (context,currentValue)async
                  //   {
                  //     var time=await showTimePicker(
                  //       context:context,
                  //  initialTime:TimeOfDay.fromDateTime(currentValue??DateTime.now()));
                  //   return DateTimeField.convert(time);
                  //     // showDatePicker(
                  //     //   context: context, 
                  //     //   initialDate: DateTime.now(), 
                  //     //   firstDate: DateTime(1999),
                  //     //    lastDate: currentValue?? DateTime(2100)
                  //     //    );
                  //   }
                    )
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                    
                  //   children:<Widget>[
                  //     Text("Time",style:_myCustomStyle),

                      
                      
                  //   ]
                  // )
                  ),
                    Padding(padding: const EdgeInsets.only(top:10.0,left:0.0),
                  child:TextField(
                    controller: titleController,
                    onChanged: (value)
                    {
                      updateTitle();
                    },
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: "Task title",
                      hintStyle: TextStyle(color:Colors.grey),
                      border: InputBorder.none
                    ),
                  ),),
                   Padding(padding: const EdgeInsets.only(top:10.0,left:0.0),
                  child:TextField(
                    controller: discriptionController,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.left,
                    onChanged: (value){
                      updateDiscription();
                    },
                    // enabled: false,
                    decoration: InputDecoration(
                      hintText: "Discription",
                      hintStyle: TextStyle(color:Colors.grey),
                      border: InputBorder.none
                    ),
                  ),),
                  
                 Padding(padding: const EdgeInsets.only(top:29.0,left: 159.0),
                 child: RaisedButton(
                   onPressed: (){
                     setState(() {
                       
                       _save();
                     });
                   },
                   child: Text("Save",style: Theme.of(context).primaryTextTheme.button,),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(19.0))),
                   color: Color(0xff8d70fe),
                   colorBrightness: Brightness.dark,
                   ),
                   ),
        
                ],
              ),
            ],
          ),
        ),
    );
 }
colorContainer(_width,_height,_color)
{
  return GestureDetector(
      onTap: (){

      },
      child: Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        shape:BoxShape.rectangle,
        color: _color,
        border: Border.all(width:0.6,color:Colors.black)
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
async
{
 await Future.delayed(Duration(seconds:2,),(){});
   
  Alert(context: context, 
  title:title,
  desc: msg,

  type: alertType,
   
  buttons: [
    DialogButton(
      child: Text(buttonText),
     onPressed: bFunction
     ),
  ],
  ).show();
// showDialog(context: context,
// builder:(context)
// {
//   return AlertDialog(
//     title: Text(title),
//     content: Text(msg),
//     actions: <Widget>[
//       RaisedButton(
//         onPressed: (){
//           Navigator.pop(context);
//         },
//         child: Text(buttonText),)
//     ],
    


  // ) ;
// });
}

//A function which delete note from database 
 void delete()async
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

}