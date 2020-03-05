import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:leo_todo_app/Models/Note.dart';

class DatabaseHelper{

static DatabaseHelper _databaseHelper;//singletons instance of DatabaseHelper()
   //bcoz this will initialized only once through out the whole program execution.


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
  await db.execute('CREATE TABLE $tabName($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
  '$colTitle TEXT,$colDiscription TEXT,$colPriorities INTEGER,$colDate TEXT  )');

}
}