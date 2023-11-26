import 'package:flutter/material.dart';

DateTime? selectedDate; // Declare selectedDate as nullable

Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
}

class MyButtonLikeTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle button click here
        _selectDate;
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Click me',
              style: TextStyle(fontSize: 16.0),
            ),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
