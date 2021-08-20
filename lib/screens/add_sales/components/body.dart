import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gjkl_trading/Database/models/salesDBModel.dart';
import 'package:gjkl_trading/Database/salesDB.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

final _formKey = GlobalKey<FormState>();

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(height: size.width * 0.1),
                AddSalesForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddSalesForm extends StatefulWidget {
  const AddSalesForm({Key? key}) : super(key: key);

  @override
  _AddSalesFormState createState() => _AddSalesFormState();
}

class _AddSalesFormState extends State<AddSalesForm> {
  String brandName = "";
  String description = "";
  double price = 0.0;
  int count = 0;
  final List<String> errors = [];
  final List<String> errors1 = [];
  TextEditingController _controllerBrand = TextEditingController();
  TextEditingController _controllerDesc = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
  TextEditingController _controllerCount = TextEditingController();
  TextEditingController _controllerCust = TextEditingController();
  TextEditingController dateCtl = TextEditingController();
  final List<String> itemBrand = [];
  final List<String> itemDescription = [];
  final List<int> itemCount = [];
  final List<String> itemDate = [];
  final List<double> itemPrice = [];
  late bool yesNo = false;

  DateTime dateOrdered = DateTime.now();

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

  void removeError1({required String error}) {
    if (errors1.contains(error))
      setState(() {
        errors1.remove(error);
      });
  }

  void addError1({required String error}) {
    if (!errors1.contains(error))
      setState(() {
        errors1.add(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            child: customerNameFormField(),
          ),
          Container(height: size.width * 0.05),
          SizedBox(
            child: buildDateFormField(),
          ),
          Container(height: size.width * 0.05),
          Divider(
            thickness: size.width * 0.001,
            color: Colors.white,
          ),
          Text('Item List:'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: itemBrand.length,
            itemBuilder: (context, index) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Item " +
                      (index + 1).toString() +
                      " - Brand: " +
                      itemBrand[index] +
                      ", Description: " +
                      itemDescription[index] +
                      ", \n₱" +
                      itemPrice[index].toString() +
                      ", Count: " +
                      itemCount[index].toString() +
                      ", Total: " +
                      (itemPrice[index] * itemCount[index]).toString(),
                ),
              ],
            ),
          ),
          Divider(
            thickness: size.width * 0.001,
            color: Colors.white,
          ),
          Container(height: size.width * 0.05),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                children: <Widget>[
                  Container(height: size.width * 0.05),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          errors1.clear();
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            if (errors.isEmpty) {
                              setState(() {
                                itemBrand.add(brandName);
                                itemDescription.add(description);
                                itemPrice.add(price);
                                itemCount.add(count);
                                itemDate.add(dateCtl.text);
                              });
                              _controllerCount.clear();
                              _controllerBrand.clear();
                              _controllerPrice.clear();
                              _controllerDesc.clear();
                            }
                          }
                        },
                        icon: Icon(
                          Icons.queue_outlined,
                          color: Colors.white,
                        ),
                      ),
                      Text(" Add")
                    ],
                  ),
                  Container(height: size.width * 0.05),
                  SizedBox(
                    child: brandNameTextFormField(),
                  ),
                  Container(height: size.width * 0.05),
                  SizedBox(
                    child: descriptionTextFormField(),
                  ),
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
                  Container(height: size.width * 0.05),
                ],
              ),
            ),
          ),
          Container(height: size.width * 0.05),
          Column(
            children: List.generate(errors.length,
                (index) => formErrorText(error: errors[index], size: size)),
          ),
          Column(
            children: List.generate(errors1.length,
                (index) => formErrorText(error: errors1[index], size: size)),
          ),
          Container(height: size.width * 0.05),
          Container(
            width: size.width * 0.15,
            height: size.width * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
            ),
            child: IconButton(
              onPressed: () async {
                errors.clear();
                if (dateCtl.text.isNotEmpty &&
                    _controllerCust.text.isNotEmpty &&
                    itemBrand.isNotEmpty) {
                  //await showAlert(context);
                  ArtDialogResponse response = await ArtSweetAlert.show(
                      barrierDismissible: false,
                      context: context,
                      artDialogArgs: ArtDialogArgs(
                          denyButtonText: "Cancel",
                          title: "Are you sure you want to Proceed?",
                          confirmButtonText: "Yes",
                          type: ArtSweetAlertType.warning));
                  if (response.isTapConfirmButton) {
                    final res = await addSales();
                    print(jsonEncode(res));
                    if (jsonEncode(res).contains(brandName)) {
                      ArtDialogResponse res1 = await ArtSweetAlert.show(
                          context: context,
                          artDialogArgs: ArtDialogArgs(
                            type: ArtSweetAlertType.success,
                            title: "Successfully Save!",
                          ));
                      if (res1.isTapConfirmButton) {
                        return;
                      }
                    } else {
                      ArtDialogResponse res1 = await ArtSweetAlert.show(
                          context: context,
                          artDialogArgs: ArtDialogArgs(
                              type: ArtSweetAlertType.danger,
                              title: "Oops...",
                              text: "Error Saving Transaction!"));
                      if (res1.isTapConfirmButton) {
                        return;
                      }
                    }
                  } else {
                    return;
                  }
                }
                if (_controllerCust.text.isEmpty) {
                  addError1(error: customerNameIsEmpty);
                } else {
                  removeError1(error: customerNameIsEmpty);
                }
                if (dateCtl.text.isEmpty) {
                  addError1(error: dateIsEmpty);
                } else {
                  removeError1(error: dateIsEmpty);
                }
                if (itemBrand.isEmpty) {
                  addError1(error: itemIsEmpty);
                } else {
                  removeError1(error: itemIsEmpty);
                }
              },
              icon: Icon(
                Icons.check_circle_outline_outlined,
                color: kPrimaryColor,
                size: size.width * 0.1,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<SalesDBModel> addSales() async {
    double total = 0.0;
    for (int i = 0; i < itemPrice.length; i++) {
      total += (itemPrice[i] * itemCount[i]);
    }
    //   final List<String> itemBrand = [];
    // final List<String> itemDescription = [];
    // final List<int> itemCount = [];
    // final List<String> itemDate = [];
    // final List<double> itemPrice = [];
    String desc = "";
    for (int i = 0; i < itemBrand.length; i++) {
      desc += "Item " +
          (i + 1).toString() +
          " - Brand: " +
          itemBrand[i] +
          ", Description: " +
          itemDescription[i] +
          ", ₱" +
          itemPrice[i].toString() +
          ", Count: " +
          itemCount[i].toString() +
          ", Total: ₱" +
          (itemPrice[i] * itemCount[i]).toString() +
          " - ";
    }
    final salesAdd = SalesDBModel(
        customerName: _controllerCust.text.trim(),
        description: desc,
        total: total,
        dateTime: DateTime.parse(dateCtl.text),
        dateTimeTDT: DateTime.now());
    SalesDBModel res = await SalesDB.instance.create(salesAdd);
    return res;
  }

  TextFormField countTextFormField() {
    return TextFormField(
      controller: _controllerCount,
      onSaved: (newValue) => count = int.parse(
        newValue.toString().isEmpty ? "0" : newValue.toString(),
      ),
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
      onSaved: (newValue) => price = double.parse(
        newValue.toString().isEmpty ? "0.00" : newValue.toString(),
      ),
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

  TextFormField descriptionTextFormField() {
    return TextFormField(
      controller: _controllerDesc,
      onSaved: (newValue) => description = newValue.toString(),
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

  TextFormField brandNameTextFormField() {
    return TextFormField(
      controller: _controllerBrand,
      onSaved: (newValue) => brandName = newValue.toString(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: brandNameIsEmpty);
        }
        return null;
      },
      validator: (value) {
        if (value != null && value.isEmpty) {
          addError(error: brandNameIsEmpty);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Brand",
        hintText: "Enter Branch Name",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white70),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Row formErrorText({required String error, required Size size}) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/Error.svg",
          height: size.height * 0.02,
          width: size.width * 0.05,
        ),
        SizedBox(
          width: size.width * 0.05,
        ),
        Text(
          error,
          style: TextStyle(color: Colors.redAccent),
        ),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != dateOrdered) {
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      String formatted = formatter.format(picked);
      setState(() {
        dateCtl.text = formatted;
        if (dateCtl.text.isNotEmpty) {
          removeError(error: dateIsEmpty);
        }
      });
    }
  }

  TextFormField buildDateFormField() {
    return TextFormField(
      controller: dateCtl,
      onTap: () {
        _selectDate(context);
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      decoration: InputDecoration(
        labelText: "Date Ordered",
        hintText: "Select Ordered Date",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white70),
        // if you are using latest version of flutter then label text and hint text shown like
        // if you are using flutter old  1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(
          Icons.calendar_today_outlined,
          color: Colors.white,
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
}
