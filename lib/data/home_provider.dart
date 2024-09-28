import 'package:db_management/data/db/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'model/table_model.dart';

class HomePageProvider extends ChangeNotifier {
  List<Map<String, dynamic>>? _mData;
  final DBHelper _dbRef = DBHelper.getInstance;

  // getInstance() {
  //   _dbRef = DBHelper.getInstance;
  // }

  HomePageProvider() {
    _fetchData();
  }

  List<Map<String, dynamic>> getData() {
    return _mData ?? [];
  }

  _fetchData() async {
    _mData = await _dbRef.getAllNotes() ?? [];
    notifyListeners();
  }

  Future<bool> addData(String mTitle, String mDesc) async {
    bool res = await _dbRef.addNote(mTitle: mTitle, mDesc: mDesc);
    print("The data has been added or note : $res");
    if (res) {
      _fetchData();
    } else {
      print("Error while adding the notes !");
    }
    return res;
  }

  Future<bool> updateData(Note note) async {
    bool res = await _dbRef.updateNote(note);
    if (res) {
      // notifyListeners();
      _fetchData();
      return res;
    } else {
      print("error while updating the data !!");
      return res;
    }
  }

  Future<bool> deleteNote(int id) async {
    bool res = await _dbRef.deleteNote(id);
    if (res) {
      // notifyListeners();
      _fetchData();
      return res;
    } else {
      print("error while deleting the data !!");
      return res;
    }
  }
}
