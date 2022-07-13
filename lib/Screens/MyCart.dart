import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop24u/api/APIService.dart';
import 'package:shop24u/model/CartResponse.dart';
import 'package:shop24u/size/MySize.dart';
import '../../api/Environment.dart';
import '../../colors/MyColors.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);
  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  late bool load;

  List<CartData> cart = [];

  SharedPreferences? sharedPreferences;
  GlobalKey key = GlobalKey();

  List<String> total_list = ["Subtotal", "Grand Total"];

  @override
  void initState() {
    load = false;
    start();
  }

  start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: MyColors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: MyColors.colorPrimary,
        title: Text(
          "My Cart",
          style: TextStyle(
              color: MyColors.black,
              fontSize: MySize.font15(context)
          ),
        ),
        iconTheme:IconThemeData(color: MyColors.black),
      ),
      body: load
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:MySize.size5(context)),
                child: Column(
                    children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical:MySize.sizeh3(context)
                          ),
                          child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: cart.length,
                              separatorBuilder: (BuildContext ctx, index) {
                                return SizedBox(
                                  height: MySize.sizeh3(context),
                                );
                              },
                              itemBuilder: (BuildContext ctx, index) {
                                return getProductDesign(cart[index], index);
                              }
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: MySize.sizeh2(context)),
                          child: Text(
                            "Order Summary",
                            style: TextStyle(
                              fontSize: 18
                            ),
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: MySize.sizeh3(context)),
                          child: Row(
                            children: [
                              Flexible(
                                child: Container(
                                  height: 50,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Coupon Code",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: MyColors.grey10),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5)
                                        )
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: MyColors.grey80,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5)
                                  )
                                ),
                                child: Text(
                                  "Apply",
                                  style: TextStyle(
                                    color: MyColors.white,
                                    fontSize: 16
                                  ),
                                ),
                              )
                            ],
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: MySize.sizeh3(context)),
                          child: getTotal()
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: MySize.sizeh3(context)),
                          child: SizedBox(
                            height: MySize.sizeh6(context),
                            width: MySize.size100(context),
                            child: ElevatedButton(
                                onPressed: () {
                                  
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(MyColors.colorSecondary),
                                ),
                                child: Text(
                                  "PROCEED TO CHECKOUT",
                                  style: TextStyle(
                                      color: MyColors.white,
                                      fontSize: MySize.font14(context)
                                  ),
                                )
                            ),
                          ),
                        ),
                    ]
                  ),
              ),
              )
          : Center(
              child: CircularProgressIndicator(
                color: MyColors.colorPrimary,
              ),
            ),
    );
  }

  Widget getProductDesign(CartData product, index) {
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: MyColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
            ),
          ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            product.productImage??"",
            fit: BoxFit.fill,
            width: (MySize.size100(context)-MySize.size10(context))*0.27,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName??"",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "₹ "+getAmount(index).toString(),
                    style: TextStyle(
                        fontSize: 18,
                        color: MyColors.black,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Quantity - ",
                          style: TextStyle(
                              fontSize: 18,
                              color: MyColors.black,
                          ),
                          children: [
                            TextSpan(
                              text: product.qty??"",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: MyColors.black,
                                  fontWeight: FontWeight.w500
                              ),
                            )
                          ]
                        ),
                      ),
                      Icon(
                        Icons.delete,
                        color: MyColors.black,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTotal() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: MyColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
            ),
          ]
      ),
      child: Column(
        children: [
          getAddressDesign(),
          Divider(
            thickness: 1,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                getTotalDesign("Items", "₹ "+getTotalAmount().toStringAsFixed(1)),
                SizedBox(
                  height: 10,
                ),
                getTotalDesign("Shipping", "Free"),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Free shipping to West Bengal",
                  style: TextStyle(
                      color: MyColors.colorSecondary
                  ),
                ),
              ],
            )
          ),
          Divider(
            thickness: 1,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: getTotalDesign("SubTotal", "₹ "+getTotalAmount().toStringAsFixed(1)),
          )
        ],
      ),
    );
  }

  getTotalDesign(String title, String value)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: MySize.font14(context),
                  color: MyColors.black,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: TextStyle(
                  fontSize: MySize.font14(context),
                  color: MyColors.black,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
        ),
      ],
    );
  }

  getAddressDesign()
  {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Suparna Manna, B-24, Dinesh Pally Purba Putiary Road",
                // getAddress().isEmpty ? "Select Address" : getAddress(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14,
                    color: MyColors.black,
                    fontWeight: FontWeight.w400
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child:  GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) =>
                //     DeliveryAddress(address: address))
                // ).then((value) {
                //   address = value as AddressData;
                //   setState(() {
                //
                //   });
                // });
              },
              child: Icon(
                Icons.edit,
                color: MyColors.colorEdit,
                size: 16,
              ),
            ),
          )
        ],
      ),
    );
  }

  getCartProducts() async {
    Map<String,dynamic> data = {
      "customer_id" : sharedPreferences?.getString("id")??"",
    };

    CartResponse cartResponse = await APIService().getCart(data);

    print(cartResponse.toJson());

    cart = cartResponse.status ?? false ? cartResponse.data ?? [] : [];
    //
    // sharedPreferences?.setInt("cart", cartResponse.status ?? false ? cartResponse.data?.length??0 : 0);
    //
    // getDeliveryAddress();
    load = true;
    setState(() {

    });

  }

  getDeliveryAddress() async {
    sharedPreferences = await SharedPreferences.getInstance();
    Map<String,dynamic> data = {
      "access_token" : (sharedPreferences?.getString("token")??"").toString(),
    };

    // AddressResponse addressResponse = await APIService().getDeliveryAddress(data);
    //
    // print(addressResponse.toJson());
    //
    // address = addressResponse.status ?? false ? addressResponse.data?.first ?? AddressData() : AddressData();

    setState(() {

    });

  }

  // updateCartProducts(String id, qty) async {
  //   Map<String,dynamic> data = {
  //     "access_token" : (sharedPreferences?.getString("token")??"").toString(),
  //     "qty" : qty,
  //     "cart_id" : id
  //   };
  //   StatusResponse statusResponse = await APIService().updateCart(data);
  //   print(data);
  //   print(statusResponse.toJson());
  // }

  // deleteCart(String id) async {
  //   Map<String,dynamic> data = {
  //     "access_token" : (sharedPreferences?.getString("token")??"").toString(),
  //     "cart_id" : id
  //   };
  //   StatusResponse statusResponse = await APIService().deleteCart(data);
  //   print(data);
  //   print(statusResponse.toJson());
  // }

  double getTotalAmount() {
    double amount = 0;
    cart.forEach((CartData cart) {
      amount+=double.parse(cart.amount??"0")*int.parse(cart.qty??"0");
    });
    print(amount);
    return amount;
  }

  double getAmount(index) {
    return double.parse(cart[index].amount??"0")*int.parse(cart[index].qty??"0");
  }

  // getProduct(int index)
  // {
  //   return {
  //     '"product_id"': '"'+(cart[index].productId??"")+'"',
  //     '"crust_id"': '"'+(cart[index].crustId??"")+'"',
  //     '"qty"': '"'+(cart[index].qty??"")+'"',
  //     '"size_id"': '"'+(cart[index].sizeId??"")+'"',
  //     '"amount"': '"'+(cart[index].productAmount??"")+'"',
  //     '"toppings_amount"': '"'+(cart[index].toppingsAmount??"")+'"',
  //     '"extra_cheese_amount"': '"'+(cart[index].extraCheeseAmount??"")+'"',
  //     '"toppings_id"': '"'+getToppingsId(cart[index].toppings??[])+'"'
  //   };
  // }

  // Future<void> insertOrder() async {
  //   List<Map<String, dynamic>> product = [];
  //
  //   for(int i=0; i<cart.length; i++) {
  //     product.add(getProduct(i));
  //   }
  //
  //   Map<String, dynamic> order = {
  //     "name" : address.name??"",
  //     "mobile" : address.mobile??"",
  //     "pincode" : address.pincode??"",
  //     "land_mark" : address.landMark??"",
  //     "house_no" : address.houseNo??"",
  //     "total_amount" : getTotalAmount().toString(),
  //     "json_order" : product.toString(),
  //     "access_token" : (sharedPreferences?.getString("token")??"").toString()
  //   };
  //
  //
  //   print(order);
  //   StatusResponse statusResponse = await APIService().insertOrder(order);
  //   print(statusResponse.toJson());
  //   if(statusResponse?.status ?? false) {
  //     Navigator.push(context, MaterialPageRoute(builder: (context) =>
  //         SuccessScreen())
  //     ).then((value) {
  //       load = false;
  //       setState(() {
  //
  //       });
  //       getCartProducts();
  //     });
  //   }
  //   // ScaffoldMessenger.of(key.currentState!.context).showSnackBar(SnackBar(content: Text("")));
  //
  // }

  // String getAddress() {
  //   return (address.houseNo??"")+((address.houseNo??"").isEmpty ? "" : ",")+(address.landMark??"")+((address.landMark??"").isEmpty ? "" : ",")+(address.pincode??"");
  // }

}