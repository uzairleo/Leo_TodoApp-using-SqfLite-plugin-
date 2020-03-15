import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class TdoDetailDilogue extends StatefulWidget {
  @override
  _TdoDetailDilogueState createState() => _TdoDetailDilogueState();
}

class _TdoDetailDilogueState extends State<TdoDetailDilogue> {
  var priorities=["High","Low"];
  var _myCustomStyle=TextStyle(color:Colors.black54);
  var titleController=TextEditingController();
  var discriptionController=TextEditingController();
  
  @override
  Widget build(BuildContext context) {
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
                   items: priorities.map((dropdownitem){
                     return DropdownMenuItem(
                       value: dropdownitem,
                       child: Text(dropdownitem));
                   }).toList(), 
                   onChanged: (changedValue){
                     setState(() {
                       
                     });
                   },
                   value: "Low",
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
                  Padding(padding: const EdgeInsets.only(top:10.0,left:0.0),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    
                    children:<Widget>[
                      Text("Time",style:_myCustomStyle),

                      
                      
                    ]
                  )),
                    Padding(padding: const EdgeInsets.only(top:10.0,left:0.0),
                  child:TextField(
                    controller: titleController,
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
                    // enabled: false,
                    decoration: InputDecoration(
                      hintText: "Discription",
                      hintStyle: TextStyle(color:Colors.grey),
                      border: InputBorder.none
                    ),
                  ),),
                  
                 
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
 selectTime()

{
  setState(() {
    showTimePicker(
    context: context, 
    initialTime : TimeOfDay.now());
  });
   

}
}