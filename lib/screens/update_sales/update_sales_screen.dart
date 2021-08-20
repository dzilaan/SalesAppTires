import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gjkl_trading/Database/models/salesDBModel.dart';

import 'components/body.dart';

class UpdateSalesScreen extends StatelessWidget {
  const UpdateSalesScreen({Key? key, required this.sales}) : super(key: key);
  final SalesDBModel sales;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UPDATE TRANSACTION"),
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/back_arrow.svg",
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Body(sales: sales),
    );
  }
}
