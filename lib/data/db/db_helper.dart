import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/table_model.dart';

class DBHelper {
  //singleTon class
  DBHelper._(); // stop the multiple instance of the class
  static const String TABLE_NAME = "note";
  static const String COLUMN_NOTE_SNO = "s_no";
  static const String COLUMN_NOTE_TITLE = "title";
  static const String COLUMN_NOTE_DESC = "desc";
  static const String mai = "gneorngreg";
  static final DBHelper getInstance = DBHelper._();

  Database? myDB;

  Future<Database> getDB() async {
    myDB ??= await _openDB();
    return myDB!;
    // if (myDB != null) {
    //   return myDB!;
    // } else {
    //   myDB = await _openDB();
    //   return myDB!;
    // }
  }

  Future<Database> _openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();

    String dbPath = join(appDir.path, "notesDB.db");

    return await openDatabase(dbPath, onCreate: (db, version) {
      //create all your tables here
      db.execute(
          "create table $TABLE_NAME ( $COLUMN_NOTE_SNO integer primary key autoincrement ,$COLUMN_NOTE_TITLE text , $COLUMN_NOTE_DESC text)");
    }, version: 1);
  }

  Future<bool> addNote({required String mTitle, required String mDesc}) async {
    var db = await getDB();
    int rowsAffected = await db.insert(
        TABLE_NAME, {COLUMN_NOTE_TITLE: mTitle, COLUMN_NOTE_DESC: mDesc});
    return rowsAffected > 0;
  }

  //getting all data
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db.query(TABLE_NAME);
    return mData;
  }
  //db open path-> if exits then open else create db

//update data
  Future<bool> updateNote(Note note) async {
    var db = await getDB();
    int rowAffected = await db.update(TABLE_NAME,
        {COLUMN_NOTE_TITLE: note.title, COLUMN_NOTE_DESC: note.desc},
        where: "$COLUMN_NOTE_SNO = ${note.id}");
    return rowAffected > 0;
  }

  Future<bool> deleteNote(int id) async {
    var db = await getDB();
    print("the id for delete note is : $id");
    int affectedRows = await db
        .delete(TABLE_NAME, where: "$COLUMN_NOTE_SNO = ?", whereArgs: ['$id']);
    // await db.delete(TABLE_NAME, where: "$COLUMN_NOTE_SNO = ${id}");
    return affectedRows > 0;
  }
}
