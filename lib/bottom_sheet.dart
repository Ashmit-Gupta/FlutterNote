import 'package:db_management/data/home_provider.dart';
import 'package:db_management/data/utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/model/table_model.dart';

// data[index][DBHelper.COLUMN_NOTE_TITLE
// data[index][DBHelper.COLUMN_NOTE_DESC

class BottomSheetView extends StatefulWidget {
  bool isUpdateNote;
  String? title;
  String? desc;
  int? sno;
  BottomSheetView(
      {super.key, this.isUpdateNote = false, this.title, this.desc, this.sno});

  @override
  State<BottomSheetView> createState() => _BottomSheetViewState();
}

class _BottomSheetViewState extends State<BottomSheetView> {
  //controllers

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.isUpdateNote) {
      _titleController.text = widget.title!;
      _descController.text = widget.desc!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              widget.isUpdateNote ? "Edit Note" : "Add Note",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 21,
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  hintText: "Enter Title Here",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: _descController,
              maxLines: 4,
              decoration: InputDecoration(
                label: Text("Desc"),
                hintText: "Enter desc here",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    onPressed: () {
                      var title = _titleController.text;
                      var desc = _descController.text;
                      if (title.isEmpty || desc.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Title and the desc cant be empty", context);
                        print("EMprty h dono title and msg don");
                      } else {
                        Note note =
                            Note(desc: desc, title: title, id: widget.sno);
                        widget.isUpdateNote
                            ? context.read<HomePageProvider>().updateData(note)
                            : context
                                .read<HomePageProvider>()
                                .addData(title, desc);
                        Navigator.pop(context);
                        widget.isUpdateNote
                            ? Utils.flushBarSuccessfullMessage(
                                "Note updated Successfully !", context)
                            : Utils.flushBarSuccessfullMessage(
                                "Note added Successfully !", context);
                      }
                    },
                    child: Text(widget.isUpdateNote ? "Save" : "Add Note"),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
