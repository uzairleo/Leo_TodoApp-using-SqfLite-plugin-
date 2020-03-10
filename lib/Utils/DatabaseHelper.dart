import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:leo_todo_app/Models/Note.dart';

class DatabaseHelper
  {
  static DatabaseHelper _databaseHelper;//singletons instance of DatabaseHelper()
   //bcoz this will initialized only once through out the whole program execution.

static Database _database;//Also Singletons instance of DatabaseHelper class
//we will used getter for this reference variable at the end 

//now create Table of Database and the column that we used inside it
String tabName="NoteTable";
String colId="id";
String colTitle="title";
String colDiscription="discription";
String colPriorities="priorities";
String colDate="date";


DatabaseHelper._createInstance();//a named constructor for nullChecking

factory DatabaseHelper()
//factory is used so that it allow us to return something from a constructor too
{
  if(_databaseHelper==null)
  {
    _databaseHelper=DatabaseHelper._createInstance();
  }
  return _databaseHelper;
}
//A function that will help us to execute the statement to create our database
 void _createDB(Database db,int newVersion)//here sql offered us this Database class
async{
                    //its a query used for creating table in any sql based database    
  await db.execute('CREATE TABLE $tabName($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
  '$colTitle TEXT,$colDiscription TEXT,$colPriorities INTEGER,$colDate TEXT  )');
}

//now its time to initialize database
Future<Database> initializedDatabase()
async
{
  //now we have to get the particular directory of each os (android or ios )where our database will create
  Directory directory= await getApplicationDocumentsDirectory();
  String path=directory.path+'notes.db';//notes.db is the of the file that we concetenate with the pah
  
  Database noteDatabase= await openDatabase(path,version: 1,onCreate: _createDB);
return noteDatabase;
}

//now its time to create a getter for our _database reference variable or singleton object
Future<Database> get database async {
//as the object is SINGLETONS SO here we check for null if its mean _database object null then initialized then move ahead
if(_database==null)
{
  _database=await initializedDatabase();
}
  return _database;
}

//Now we have to do the CRUD operation(Create ,Retrieve,Update and Delete)
//using these funtions


//1=>Retrieving/Reading Operation: Get all Note Objects from database
Future<List<Map<String,dynamic>>> getMapList()async
{
  Database db= await this.database;
  // String sqlrawaQuery='SELECT * FROM $tabName order by $colPriorities ASC';
  // var result=await db.rawQuery(sqlrawaQuery);//using raw SQL queries
  var result=await db.query(tabName,orderBy: '$colPriorities ASC');//using helpers funciton both have same result
  return result;
}

//Insert/Write/save operation : Insert a Note object to database

Future<int> insertNote(Note note)async
{
  Database db=await this.database;
  
  var result= await db.insert(tabName, note.toMap());
return result;
}
//Update operation : Update a Note object and save it to database

Future<int> updateNote(Note note)async
{
  Database db=await this.database;

  var result=await db.update(tabName, note.toMap(),where: '$colId = ?',whereArgs: [note.getId]);
return result;
}
//Delete Operation : Delete a note object from database
Future<int> deleteNote(int id)async
{
  Database db=await this.database;
  // db.delete(tabName);
  var result =await db.rawDelete('DELETE FROM $tabName WHERE $colId =$id');
return result;
}
//get all number of Note objecs in database or number of records in our table
Future<int> getCount()async
{
  Database db=await this.database;
  List<Map<String,dynamic>> count=await db.rawQuery('SELECT COUNT (*) from $tabName');
  int result =Sqflite.firstIntValue(count);
  return result;
}

Future<List<Note>> getNoteList()async
{//now converting list<map> to List<Note> 
  var noteMaplist=await getMapList();
  int count=noteMaplist.length;

  List<Note> noteList=List<Note>();
  for(int i=0;i< count ;i++)

  {
      noteList.add(Note.fromMapObject(noteMaplist[i]));
  }

  return noteList;

}

 

}