import 'package:flutter/material.dart';


class TodoDetail extends StatefulWidget {
  @override
  _TodoDetailState createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
 static var _priorities=["High","Low"];
  @override
  Widget build(BuildContext context) {
    
 var textStyle=Theme.of(context).textTheme.title;  
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),

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
             controller: null,
             onChanged: null,
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
           controller: null,
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
              onPressed: (){},
              child:Text("Save",textScaleFactor: 1.5,),
              color: Theme.of(context).primaryColorDark,
              textColor: Theme.of(context).primaryColorLight,
              ),),
              SizedBox(width:10),
              Expanded(
                child: RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  onPressed: (){},
                  child:Text("Exit",textScaleFactor: 1.5,))),
          ],
        ),
      ),
       
        ]
      ),
    ),  
    );

  }
}