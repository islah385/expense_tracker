import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ModalBsheet extends StatefulWidget {
  List<Map<String, dynamic>> data;
  Function getTotal;

  ModalBsheet({required this.data, required this.getTotal});

  @override
  State<ModalBsheet> createState() => _ModalBsheetState();
}

class _ModalBsheetState extends State<ModalBsheet> {
  String? selectedCat;
  double? amount;
  List<String> _categoryItems = [
    'Shopping',
    'Travel',
    'Grocery',
    'Entertainment',
    'Others'
  ];

  final textController = TextEditingController();
  void showSelectedItem(String value) {
    setState(() {
      selectedCat = value;
    });
  }

  void validate(String value) {
    double? check = double.tryParse(value);
    if (check != null && selectedCat != null) {
      amount = check;
      addExp(category: selectedCat, amount: amount);

      textController.clear();

      Fluttertoast.showToast(
          msg: "This is Center Short Toast",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {


      
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid input')));
    }
  }

  void addExp({required String? category, required double? amount}) {
    Map<String, dynamic> expenseData = {'category': category, 'amount': amount};
    widget.data.add(expenseData);
    widget.getTotal(amount);

    // print(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width: 320,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cost',
                  suffixIcon: Icon(Icons.currency_rupee),
                ),
                keyboardType: TextInputType.number,
                controller: textController,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(right: 10, left: 10),
              width: 320,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownButton<String>(
                value: selectedCat,
                isExpanded: true,
                hint: Text('Select Type'),
                items: _categoryItems.map((String selectedItem) {
                  return DropdownMenuItem<String>(
                    child: Text(selectedItem),
                    value: selectedItem,
                  );
                }).toList(),
                onChanged: (String? value) {
                  if (value != null) {
                    showSelectedItem(value);
                  }
                },
                underline: SizedBox(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 30,
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  validate(textController.text);

                  Navigator.pop(context, widget.data);
                },
                child: Text('Add to Expense'),
              ),
            )
          ],
        ));
  }
}
