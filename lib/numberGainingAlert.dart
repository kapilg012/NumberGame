import 'package:flutter/material.dart';

import 'CommonWidgets.dart';

class NumberGainingAlert extends StatefulWidget {
  String name;

  NumberGainingAlert(this.name);

  @override
  _NumberGainingAlertState createState() => _NumberGainingAlertState();
}

class _NumberGainingAlertState extends State<NumberGainingAlert> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            "${widget.name}'s Board",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          spacingVerticalNormal,
          Text(
            "Enter Your Magic Number",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          spacingVerticalNormal,
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.purpleAccent)),
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
            ),
          ),
          spacingVerticalNormal,
          InkWell(
            onTap: () {
              Navigator.pop(context, double.parse(controller.text));
              controller.text = "";
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.green),
              child: const Center(
                child: Text(
                  "Confirm",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
