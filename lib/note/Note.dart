

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

 //now a funtion which convert simple data to map objects
 //(FOR WRITING/SAVING DATA FROM DATABASE)





 //And now a function that extract simple data from map Object reverse of the above one
//OR convert map objects to simple data
//(FOR READING/RETRIEVING DATA FROM DATABASE)



}