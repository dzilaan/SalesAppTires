import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'components/body.dart';

class AddSalesScreen extends StatelessWidget {
  const AddSalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text("ADD SALES"),
      ),
      body: Body(),
    );
  }
}
