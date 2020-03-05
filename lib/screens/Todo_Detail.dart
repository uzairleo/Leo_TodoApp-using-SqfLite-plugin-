// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:leo_todo_app/screens/Todo_list.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TodoDetail extends StatefulWidget {
 String appBartitle;
      TodoDetail(this.appBartitle);
   @override
  _TodoDetailState createState() => _TodoDetailState(appBartitle);
}

class _TodoDetailState extends State<TodoDetail> {
 static var _priorities=["High","Low"];
 String appBartitle;
//  int result;
 TextEditingController titleController=TextEditingController();
TextEditingController discriptionController=TextEditingController();
 _TodoDetailState(this.appBartitle);
 
  @override
  Widget build(BuildContext context) {

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
                value: _priorities[0],
                onChanged:(valuechange)
                {
                  setState(() {
                    print("done");
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
               onChanged: (value){},
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
             onChanged: null,
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
                      moveToList();

                      });
                    },
                    child:Text("Exit",textScaleFactor: 1.5,))),
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
     Alert(
      context: context,
      title: "Quit",
      desc: "Make sure you save you todo otherwise it will not save automatically",
      type: AlertType.warning,
      buttons: [
        DialogButton(
          child: Text("Exit",
          style: TextStyle(fontSize: 22,color:Colors.white),),
          onPressed: (){

            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context)
              {
                
                return Todolist();

              })
              );
         },
          width: 120,),
          ],
       closeFunction: (){
         Navigator.of(context).pop();
       } 
      ).show();
  }

  //  sum()
  // {
  //   int x=int.parse(titleController.text);
  //   int y=int.parse(discriptionController.text);
  //   int sum=x+y;
  //   return sum;
  // }
}