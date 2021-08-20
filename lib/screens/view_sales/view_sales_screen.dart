import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'components/body.dart';

class ViewSalesScreen extends StatelessWidget {
  const ViewSalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("VIEW SALES"),
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
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.date_range_outlined),
                text: "By Range",
              ),
              Tab(
                icon: Icon(Icons.list_alt_rounded),
                text: "View All",
              ),
            ],
          ),
        ),
        body: Body(),
      ),
    );
  }
}
