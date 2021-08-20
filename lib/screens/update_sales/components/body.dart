import 'package:flutter/material.dart';
import 'package:gjkl_trading/Database/models/salesDBModel.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.sales}) : super(key: key);
  final SalesDBModel sales;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _controllerCust = TextEditingController();
  TextEditingController _controllerDesc = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
  TextEditingController _controllerCount = TextEditingController();

  final List<String> errors = [];
  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            children: <Widget>[
              Container(height: size.width * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "ID: " + widget.sales.id.toString(),
                    style: TextStyle(fontSize: size.width * 0.05),
                  ),
                ],
              ),
              Container(height: size.width * 0.05),
              customerNameFormField(),
              Container(height: size.width * 0.05),
              Text(
                "Item: " + widget.sales.id.toString(),
                style: TextStyle(fontSize: size.width * 0.05),
              ),
              Container(height: size.width * 0.05),
              descriptionTextFormField(),
              Container(height: size.width * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 0.38,
                    child: priceTextFormField(),
                  ),
                  SizedBox(
                    width: size.width * 0.38,
                    child: countTextFormField(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField customerNameFormField() {
    return TextFormField(
      controller: _controllerCust,
      decoration: InputDecoration(
        labelText: "Customer Name",
        hintText: "Enter Customer Name",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white70),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(
          Icons.account_circle_outlined,
          color: Colors.white,
        ),
      ),
    );
  }

  TextFormField descriptionTextFormField() {
    return TextFormField(
      controller: _controllerDesc,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: descriptionIsEmpty);
        }
        return null;
      },
      validator: (value) {
        if (value != null && value.isEmpty) {
          addError(error: descriptionIsEmpty);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Description",
        hintText: "Enter Description",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white70),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField countTextFormField() {
    return TextFormField(
      controller: _controllerCount,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: countIsEmpty);
        }
        return null;
      },
      validator: (value) {
        if (value != null && value.isEmpty) {
          addError(error: countIsEmpty);
        }
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Count",
        hintText: "Enter Count",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white70),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField priceTextFormField() {
    return TextFormField(
      controller: _controllerPrice,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: priceIsEmpty);
        }
        return null;
      },
      validator: (value) {
        if (value != null && value.isEmpty) {
          addError(error: priceIsEmpty);
        }
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Price",
        hintText: "Enter Price",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white70),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
