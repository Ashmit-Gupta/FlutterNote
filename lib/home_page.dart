import 'package:db_management/bottom_sheet.dart';
import 'package:db_management/data/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/db/db_helper.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Database"),
      ),
      body: Center(
        child: Consumer<HomePageProvider>(
          builder: (_, provider, __) {
            var data = provider.getData();
            return data.isNotEmpty
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        leading:
                            Text("${data[index][DBHelper.COLUMN_NOTE_SNO]}"),
                        title: Text(data[index][DBHelper.COLUMN_NOTE_TITLE]),
                        subtitle: Text(data[index][DBHelper.COLUMN_NOTE_DESC]),
                        trailing: SizedBox(
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  print(index);
                                  provider.deleteNote(
                                      data[index][DBHelper.COLUMN_NOTE_SNO]);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) => BottomSheetView(
                                            isUpdateNote: true,
                                            title: data[index]
                                                [DBHelper.COLUMN_NOTE_TITLE],
                                            desc: data[index]
                                                [DBHelper.COLUMN_NOTE_DESC],
                                            sno: data[index]
                                                [DBHelper.COLUMN_NOTE_SNO],
                                          ));
                                },
                                child: Icon(
                                  Icons.edit,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Text("The data is empty !!");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => BottomSheetView());
          // scrollControlDisabledMaxHeightRatio:
          //     MediaQuery.of(context).size.height * 0.3);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
