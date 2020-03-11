//creating table of database

class Note{

  int _id;
  String _title;
  String _discription;
  String _date;
  int _priorities;

  Note(this._title,this._date,this._priorities,[this._discription]);
  Note.withId(this._id,this._title,this._date,this._priorities,[this._discription]);
  //getters
  int get getId => _id;
  String get getTitle => _title;
  String get getDiscription => _discription;
  String get getDate => _date;
  int get getPriorities => _priorities;
  //setters
  // set id(int newid){   //as we dont need to set id bcoz thats automatically
                          //done in the database 
  // }
 set setTitle(String newTitle) 
 {
   if(newTitle.length<=255){
   this._title=newTitle;
   }
 }
 
 set setDiscription(String newDisc)
 {
   if(newDisc.length<=255)
   {
     this._discription=newDisc;
   }
 }

 set setDate(String newDate)
 {
   if(newDate.length<50)
   {
     this._date=newDate;
   }
 }

 set setPriorities(int newPriority)
 {
   if(newPriority>=1 && newPriority<=2)
 {
   this._priorities=newPriority;
 }
 }

 //now a funtion which convert Note object to map objects
 //(FOR WRITING/SAVING DATA FROM DATABASE)

Map<String,dynamic> toMap()
{

  var dataToMap=Map<String,dynamic> ();
  if(_id!=null){
   dataToMap['id']=_id;
    }
     dataToMap['title']=_title;
   dataToMap['discription']=_discription;
   dataToMap['date']=_date;
   dataToMap['priorities']=_priorities;
return dataToMap;

}

 //And now a function that extract Note object from map Object reverse of the above one
//OR convert map objects to simple data or note object
//(FOR READING/RETRIEVING DATA FROM DATABASE)
//this is named constructor
Note.fromMapObject(Map<String,dynamic> mapTodata)
{
  this._id=mapTodata['id'];
  this._title=mapTodata['title'];
  this._discription=mapTodata['discription'];
  this._date=mapTodata['date'];
  this._priorities=mapTodata['priorities'];
}


}