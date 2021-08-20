import 'package:flutter/material.dart';
import 'package:gjkl_trading/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   // leading: IconButton(
      //   //   icon: SvgPicture.asset("assets/icons/menu.svg"),
      //   //   onPressed: () {},
      //   // ),
      //   backgroundColor: Colors.white,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       Text(
      //         "GJKL Trading",
      //         style: TextStyle(
      //             color: Colors.black,
      //             fontWeight: FontWeight.w700,
      //             fontSize: MediaQuery.of(context).size.width * 0.07),
      //       ),
      //     ],
      //   ),
      // ),
      body: Body(),
    );
  }
}
