import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreatePerson extends StatelessWidget {
  final List<String> _dropdownValues = ["นาย", "นาง", "นางสาว"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สร้างผู้ต้องหา',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'ประเภทผู้ต้องหา',
              style: TextStyle(fontSize: 18),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: 1,
                  onChanged: (value) {},
                ),
                Text('บุคคล'),
                Radio(
                  value: 0,
                  groupValue: 1,
                  onChanged: (value) {},
                ),
                Text('นิติบุคคล'),
              ],
            ),
            Text(
              'สํญชาติผู้ต้องหา',
              style: TextStyle(fontSize: 18),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: 1,
                  onChanged: (value) {},
                ),
                Text('คนไทย'),
                Radio(
                  value: 0,
                  groupValue: 1,
                  onChanged: (value) {},
                ),
                Text('คนต่างด้าว'),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'x-xx-x-xxx-xxxxx-x',
                  hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                  labelText: 'หนังสือเดินทาง',
                  labelStyle: TextStyle(fontSize: 18)),
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'ประเทศหนังสือเดินทาง',
                  labelStyle: TextStyle(fontSize: 18)),
            ),
            new Row(
              children: <Widget>[
                Text('คำนำหน้าชื่อ    ',style: TextStyle(fontSize: 18)),
                DropdownButton(
                  items: _dropdownValues
                      .map((value) => DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (String value) {},
                  isExpanded: false,
                  hint: Text('-- เลือก ---'),
                ),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  fillColor: Colors.white,
                  hintText: 'ผู้ต้องหา',
                  filled: true,
                  labelText: 'ชื่อ นามสกุล',
                  labelStyle: TextStyle(fontSize: 18)),
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  fillColor: Colors.white,
                  hintText: 'ชื่อ นามสกุล',
                  filled: true,
                  labelText: 'บิดา',
                  labelStyle: TextStyle(fontSize: 18)),
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  fillColor: Colors.white,
                  hintText: 'ชื่อ นามสกุล',
                  filled: true,
                  labelText: 'มารดา',
                  labelStyle: TextStyle(fontSize: 18)),
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'ที่อยู่ผู้ต้องหา',
                  hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                  labelText: 'ที่อยู่',
                  labelStyle: TextStyle(fontSize: 18)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              maxLines: 3,
              maxLengthEnforced: true,
            ),
          ],
        ),
      ),
    );
  }
}
