import 'package:bordered_text/bordered_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gjkl_trading/screens/add_sales/add_sales_screen.dart';
import 'package:gjkl_trading/screens/view_sales/view_sales_screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<String> imgList = [
      "assets/images/add1.png",
      "assets/images/add2.png",
      "assets/images/add3.png"
    ];
    return Container(
      height: size.height,
      width: size.width,
      color: Color(0xFF303A4A),
      child: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.67,
            child: Stack(
              children: <Widget>[
                CarouselSlider(
                  options: CarouselOptions(
                    height: size.height * 0.635,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    autoPlay: true,
                    // autoPlay: false,
                  ),
                  items: imgList
                      .map((item) => Container(
                            child: Center(
                                child: Image.asset(
                              item,
                              fit: BoxFit.cover,
                              height: size.height * 0.65,
                              width: size.width,
                            )),
                          ))
                      .toList(),
                ),
                Positioned(
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: size.width * 0.12,
                        width: size.width * 0.05,
                      ),
                      Container(
                        height: size.width * 0.15,
                        width: size.width * 0.15,
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: Colors.white, width: 1),
                        //   borderRadius: BorderRadius.circular(90),
                        // ),
                        child: SvgPicture.asset(
                          "assets/icons/logo.svg",
                          color: Colors.green,
                        ),
                      ),
                      BorderedText(
                        strokeWidth: 2.0,
                        strokeColor: Colors.white,
                        child: Text(
                          ' GJKL Trading',
                          style: TextStyle(
                              color: Colors.transparent,
                              fontSize: size.width * 0.12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            "SALES: 00001",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.04,
              color: Colors.white,
            ),
          ),
          Container(height: size.width * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddSalesScreen()),
                  );
                },
                child: Container(
                  width: size.width * 0.4,
                  height: size.height * 0.1,
                  decoration: (BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     offset: Offset(0, 10),
                    //     blurRadius: 50,
                    //     color: kPrimaryColor.withOpacity(0.23),
                    //   )
                    // ],
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFF465670),
                  )),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "ADD SALES",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.04,
                            color: Colors.white,
                          ),
                        ),
                        // SvgPicture.asset(
                        //   "assets/icons/tire.svg",
                        //   width: size.width * 0.22,
                        // )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewSalesScreen()),
                  );
                },
                child: Container(
                  width: size.width * 0.4,
                  height: size.height * 0.1,
                  decoration: (BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     offset: Offset(0, 10),
                    //     blurRadius: 50,
                    //     color: kPrimaryColor.withOpacity(0.23),
                    //   )
                    // ],
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFF465670),
                  )),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "VIEW SALES",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.04,
                            color: Colors.white,
                          ),
                        ),
                        // SvgPicture.asset(
                        //   "assets/icons/tire.svg",
                        //   width: size.width * 0.22,
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(height: size.width * 0.05),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         print("ADD SALES");
          //       },
          //       child: Container(
          //         width: size.width * 0.4,
          //         height: size.height * 0.1,
          //         decoration: (BoxDecoration(
          //           // boxShadow: [
          //           //   BoxShadow(
          //           //     offset: Offset(0, 10),
          //           //     blurRadius: 50,
          //           //     color: kPrimaryColor.withOpacity(0.23),
          //           //   )
          //           // ],
          //           borderRadius: BorderRadius.circular(30),
          //           color: Color(0xFF465670),
          //         )),
          //         child: Center(
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               Text(
          //                 "ADD PRODUCT",
          //                 style: TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: size.width * 0.04,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //               // SvgPicture.asset(
          //               //   "assets/icons/tire.svg",
          //               //   width: size.width * 0.22,
          //               // )
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         print("VIEW SALES");
          //       },
          //       child: Container(
          //         width: size.width * 0.4,
          //         height: size.height * 0.1,
          //         decoration: (BoxDecoration(
          //           // boxShadow: [
          //           //   BoxShadow(
          //           //     offset: Offset(0, 10),
          //           //     blurRadius: 50,
          //           //     color: kPrimaryColor.withOpacity(0.23),
          //           //   )
          //           // ],
          //           borderRadius: BorderRadius.circular(30),
          //           color: Color(0xFF465670),
          //         )),
          //         child: Center(
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               Text(
          //                 "VIEW/EDIT\nPRODUCT",
          //                 style: TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: size.width * 0.04,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //               // SvgPicture.asset(
          //               //   "assets/icons/tire.svg",
          //               //   width: size.width * 0.22,
          //               // )
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
