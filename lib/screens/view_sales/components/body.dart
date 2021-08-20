import 'package:flutter/material.dart';
import 'package:gjkl_trading/Database/models/salesDBModel.dart';
import 'package:gjkl_trading/Database/salesDB.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

final _formKey1 = GlobalKey<FormState>();

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TabBarView(
      children: [
        SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: size.height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                children: <Widget>[
                  Container(height: size.width * 0.1),
                  ViewSalesFormRange(),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: size.height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                children: <Widget>[
                  Container(height: size.width * 0.02),
                  SizedBox(
                      width: size.width,
                      height: size.height * 0.57,
                      child: ViewAll()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//--------------------------------------------------------------------------------------------------------
class ViewAll extends StatefulWidget {
  const ViewAll({Key? key}) : super(key: key);

  @override
  _ViewAllState createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<List<SalesDBModel>>(
      future: SalesDB.instance.reaAlldSalesDB(),
      builder:
          (BuildContext context, AsyncSnapshot<List<SalesDBModel>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = getDynamicList(size, snapshot.data!, context);
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            )
          ];
        }
        String getTotalofTransaction() {
          double totalSales = 0.0;
          snapshot.data!.forEach((element) {
            totalSales += element.total!;
          });

          return totalSales.toString();
        }

        return SizedBox(
          width: size.width,
          height: size.height * 0.808,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Transaction/s Count: " +
                      snapshot.data!.length.toString()),
                  Text("Overall Total: " + getTotalofTransaction()),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: children,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

//--------------------------------------------------------------------------------------------------------
class ViewSalesFormRange extends StatefulWidget {
  const ViewSalesFormRange({Key? key}) : super(key: key);

  @override
  _ViewSalesFormRangeState createState() => _ViewSalesFormRangeState();
}

class _ViewSalesFormRangeState extends State<ViewSalesFormRange> {
  TextEditingController dateCtl1 = TextEditingController();
  TextEditingController dateCtl2 = TextEditingController();

  DateTime date1 = DateTime.now();
  DateTime date2 = DateTime.now();
  final List<String> errors = [];
  late List<SalesDBModel> sales = [];

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

  // List<SalesDBModel> _generateItems() {
  //   return List.generate(15, (int index) {
  //     return SalesDBModel(
  //       id: index + 1,
  //       customerName: 'Item ${index + 1}',
  //       description: 'Details of item ${index + 1}',
  //       total: (index + 1) * 1000.00,
  //       dateTime: ,
  //       dateTimeTDT: ,
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey1,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: size.width * 0.45, child: buildDateFormField1(size)),
              SizedBox(
                  width: size.width * 0.45, child: buildDateFormField2(size)),
            ],
          ),
          Container(height: size.width * 0.05),
          Container(
            child: IconButton(
              onPressed: () async {
                viewbyDate();
              },
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            width: size.width,
            height: size.width * 0.15,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(28),
              ),
            ),
          ),
          Container(height: size.width * 0.02),
          // SizedBox(
          //   width: size.width,
          //   height: size.height * 0.6,
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.vertical,
          //     child: SingleChildScrollView(
          //       scrollDirection: Axis.horizontal,
          //       child: DataTable(
          //         dataRowHeight: size.width * 0.1,
          //         columns: _createColumns(),
          //         rows: List.generate(
          //           sales.length,
          //           (index) => dataRow(sales[index], index),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Divider(
            thickness: size.width * 0.02,
            color: Colors.white,
          ),
          Container(height: size.width * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Transaction/s Count: " + sales.length.toString()),
              Text("Overall Total: " + getTotalofTransaction()),
            ],
          ),
          Container(height: size.width * 0.02),
          SizedBox(
            width: size.width,
            height: size.height * 0.57,
            child: SingleChildScrollView(
              child: Column(
                children: getDynamicList(size, sales, context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void viewbyDate() async {
    final salesState = await SalesDB.instance
        .readSalesDBByDate(dateCtl1.text.trim(), dateCtl2.text.trim());
    setState(() {
      this.sales = salesState;
    });
  }

  String getTotalofTransaction() {
    double totalSales = 0.0;
    sales.forEach((element) {
      totalSales += element.total!;
    });

    return totalSales.toString();
  }

  DataRow dataRow(SalesDBModel item, int index) {
    List<bool> selected =
        List<bool>.generate(sales.length, (int index) => false);
    return DataRow(
      // index: item.id, // for DataRow.byIndex

      key: ValueKey(item.id),

      color: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        // All rows will have the same selected color.
        if (states.contains(MaterialState.selected)) {
          return Theme.of(context).colorScheme.primary.withOpacity(0.08);
        }
        // Even rows will have a grey color.
        if (index.isEven) {
          return Colors.grey.withOpacity(0.3);
        }
        return null; // Use default value for other states and odd rows.
      }),
      cells: [
        DataCell(
          Text(item.id.toString()),
        ),
        DataCell(
          Text(item.customerName.toString()),
        ),
        DataCell(
          Text(item.description.toString()),
        ),
        DataCell(
          Text(item.total.toString()),
        ),
        DataCell(
          Text(item.dateTime.toString()),
        ),
        DataCell(
          Text(item.dateTimeTDT.toString()),
        ),
      ],
      // selected: item.id,
      // onSelectChanged: (bool? isSelected) {
      //   if (isSelected != null) {
      //     item.id = isSelected;

      //     setState(() {});
      //   }
      // },
      selected: selected[index],
      onSelectChanged: (bool? isSelected) {
        if (isSelected != null) {
          setState(() {
            selected[index] = isSelected;
          });
        }
      },
    );
  }

  // List<DataColumn> _createColumns() {
  //   return [
  //     DataColumn(
  //       label: const Text('ID'),
  //       numeric: true,
  //     ),
  //     DataColumn(
  //       label: const Text('CustomerName'),
  //       numeric: false,
  //     ),
  //     DataColumn(
  //       label: const Text('Description'),
  //       numeric: false,
  //     ),
  //     DataColumn(
  //       label: const Text('Total'),
  //       numeric: false,
  //     ),
  //     DataColumn(
  //       label: const Text('TransactionDate'),
  //       numeric: false,
  //     ),
  //     DataColumn(
  //       label: const Text('DateInserted'),
  //       numeric: false,
  //     ),
  //   ];
  // }

  TextFormField buildDateFormField1(Size size) {
    return TextFormField(
      controller: dateCtl1,
      onTap: () {
        _selectDate1(context);
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      decoration: InputDecoration(
        labelText: "From*",
        hintText: "Select Date From",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white70),
        contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
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

  TextFormField buildDateFormField2(Size size) {
    return TextFormField(
      controller: dateCtl2,
      onTap: () {
        _selectDate2(context);
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      decoration: InputDecoration(
        labelText: "To*",
        hintText: "Select Date To",
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white70),
        contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
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

  _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != date1) {
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      String formatted = formatter.format(picked);
      setState(() {
        dateCtl1.text = formatted;
        if (dateCtl1.text.isNotEmpty) {
          removeError(error: dateisEmpty1);
        }
      });
    }
  }

  _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != date2) {
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      String formatted = formatter.format(picked);
      setState(() {
        dateCtl2.text = formatted;
        if (dateCtl2.text.isNotEmpty) {
          removeError(error: dateisEmpty2);
        }
      });
    }
  }
}
