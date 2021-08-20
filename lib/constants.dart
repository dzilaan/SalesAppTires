import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Database/models/salesDBModel.dart';
import 'Database/salesDB.dart';
import 'screens/update_sales/update_sales_screen.dart';

const kPrimaryColor = Color(0xFF465670);
const kLogoColor = Color(0xFF0C9869);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFF303A4A);

const double kDefaultPadding = 20.0;

//ERRORS -- ADD SALES
final String customerNameIsEmpty = "Customer Name must not be Empty! *";
final String brandNameIsEmpty = "Brand Name must not be Empty!";
final String descriptionIsEmpty = "Description must not be Empty!";
final String countIsEmpty = "Count must not be Empty!";
final String priceIsEmpty = "Price must not be Empty!";
final String dateIsEmpty = "Date Ordered must not be Empty! *";
final String itemIsEmpty = "Item list must not be Empty! *";

//ERRORS -- VIEW SALES

final String dateisEmpty1 = "Date From* must not be Empty";
final String dateisEmpty2 = "Date To* must not be Empty";

//Dynamic List Viewing of Transaction

List<Widget> getDynamicList(
    Size size, List<SalesDBModel> sales, BuildContext context) {
  List<Widget> listings = [];
  sales.forEach((element) {
    listings.add(Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: size.width * 0.02),
          GestureDetector(
            onTap: () async {
              ArtDialogResponse res1 = await ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                    denyButtonText: "Delete",
                    showCancelBtn: true,
                    confirmButtonText: "Update",
                    title: "SETTINGS",
                    text: "Selected Transaction ID: " + element.id.toString(),
                  ));
              if (res1.isTapConfirmButton) {
                //UPDATE
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateSalesScreen(sales: element)),
                );
              }
              if (res1.isTapDenyButton) {
                //DELETE
                ArtDialogResponse response = await ArtSweetAlert.show(
                    barrierDismissible: false,
                    context: context,
                    artDialogArgs: ArtDialogArgs(
                        denyButtonText: "Cancel",
                        title: "Are you sure you want to Delete?",
                        confirmButtonText: "Yes",
                        type: ArtSweetAlertType.warning));
                if (response.isTapConfirmButton) {
                  int temp = await SalesDB.instance.delete(element.id!);

                  print(
                      "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" +
                          temp.toString());
                  if (temp != 0) {
                    ArtDialogResponse res1 = await ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                          type: ArtSweetAlertType.success,
                          title: "Successfully Deleted!",
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
                            text: "Error deleting Transaction!"));
                    if (res1.isTapConfirmButton) {
                      return;
                    }
                  }
                  return;
                } else {
                  return;
                }
              }
              if (res1.isTapCancelButton) {
                //CANCEL
                return;
              }
            },
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.08,
                      ),
                      Text("ID: " + element.id.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.08,
                      ),
                      Text("Customer Name: " + element.customerName.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.08,
                      ),
                      Expanded(
                        child: Text(
                            "Description: " + element.description.toString(),
                            overflow: TextOverflow.visible),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.08,
                      ),
                      Text("Total: ₱" + element.total.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.08,
                      ),
                      Text("Date: " +
                          DateFormat('yyyy-MM-dd').format(
                              DateTime.parse(element.dateTime.toString()))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.08,
                      ),
                      Text("Transaction Date: " +
                          element.dateTimeTDT.toString()),
                    ],
                  ),
                ],
              ),
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(28),
                ),
              ),
            ),
          ),
          Container(height: size.width * 0.05),
        ],
      ),
    ));
  });

  return listings;
}
