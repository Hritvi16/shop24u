import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop24u/Screens/ProductList.dart';
import 'package:shop24u/model/CategoryResponse.dart';
import 'package:shop24u/model/ProductResponse.dart';
import 'package:shop24u/size/MySize.dart';

import '../../api/APIService.dart';
import '../../api/Environment.dart';
import '../../colors/MyColors.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool load;

  int selected = -1;
  // List<DeliveryTypeData> deliveryType = [];
  List<CategoryData> category = [];
  List<ProductData> product = [];
  // List<BannerData> we_set_us = [];
  // List<Widget> slideShow;
  // List<Widget> stories;

  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    load = false;
    // slideShow = [];
    // stories = [];
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      resizeToAvoidBottomInset: true,
      body: load
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: MySize.sizeh3(context)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: MySize.sizeh2(context), right: MySize.size5(context), left: MySize.size5(context)),
                      child: Image.asset(
                        "assets/banner/hsbanner1.png",
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        height: MySize.sizeh20(context),
                      ),
                    ),
                    getCategoryBody(),
                    getExploreBody(),
                    getBrandBody(),
                    Padding(
                      padding: EdgeInsets.only(bottom: MySize.sizeh2(context), right: MySize.size5(context), left: MySize.size5(context)),
                      child: Image.asset(
                        "assets/banner/hsbanner2.png",
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        height: MySize.sizeh20(context),
                      ),
                    ),
                    getNewArrivalBody(),
                  ]
                ),
              )
            )
          : Center(
              child: CircularProgressIndicator(
                color: MyColors.colorPrimary,
              ),
            ),
    );
  }

  getCategoryBody() {
    return Padding(
      padding: EdgeInsets.only(bottom: MySize.sizeh1(context), right: MySize.size5(context), left: MySize.size5(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: MySize.sizeh1(context)),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "SHOP BY CATEGORY",
                style: TextStyle(
                    fontSize: MySize.font14(context),
                    color: MyColors.black,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
          SizedBox(
            height: MySize.sizeh13(context),
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: category.length,
                separatorBuilder: (BuildContext ctx, index) {
                  return SizedBox(
                    width: MySize.size4(context),
                  );
                },
                itemBuilder: (BuildContext ctx, index) {
                  return getCategoryDesign(category[index], index);
                }
            ),
          ),
        ],
      ),
    );
  }

  getExploreBody() {
    return Padding(
      padding: EdgeInsets.only(bottom: MySize.sizeh1(context), right: MySize.size5(context), left: MySize.size5(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: MySize.sizeh1(context)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "EXPLORE OUR PRODUCTS",
                style: TextStyle(
                    fontSize: MySize.font14(context),
                    color: MyColors.black,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
          SizedBox(
            height: MySize.sizeh18(context),
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: product.length,
                separatorBuilder: (BuildContext ctx, index) {
                  return SizedBox(
                    width: MySize.size4(context),
                  );
                },
                itemBuilder: (BuildContext ctx, index) {
                  return getExploreDesign(product[index], index);
                }
            ),
          ),
        ],
      ),
    );
  }

  getBrandBody() {
    return Padding(
      padding: EdgeInsets.only(bottom: MySize.sizeh2(context), right: MySize.size5(context), left: MySize.size5(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: MySize.sizeh1(context)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "BRANDS WE SELL",
                style: TextStyle(
                    fontSize: MySize.font14(context),
                    color: MyColors.black,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
          SizedBox(
            height: MySize.sizeh8(context),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Image.asset(
                    "assets/brand/lenovo.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Image.asset(
                    "assets/brand/dell.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Image.asset(
                    "assets/brand/hp.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Image.asset(
                    "assets/brand/acer.png",
                    fit: BoxFit.fill,
                  ),
                )
              ],
            )
          ),
        ],
      ),
    );
  }

  getNewArrivalBody() {
    return Container(
      padding: EdgeInsets.only(bottom: MySize.sizeh2(context), right: MySize.size5(context), left: MySize.size5(context)),
      decoration: BoxDecoration(
        color: MyColors.colorNABg
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: MySize.sizeh1(context)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "NEW ARRIVALS",
                style: TextStyle(
                    fontSize: MySize.font14(context),
                    color: MyColors.black,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getPreferenceDesign(int ind) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Row(
        children: [
          Radio(
            value: ind,
            groupValue: selected,
            onChanged: (Object? value) {
              if(value==ind) {
                selected = ind;
              }
              setState(() {

              });
              print(value);
            },
          ),
          // Text(
          //   deliveryType[ind].name??"",
          //   style: TextStyle(
          //       fontSize: 12,
          //       color: MyColors.black
          //   ),
          // )
        ],
      ),
    );
  }

  Widget getCategoryDesign(CategoryData category, int index) {
    print(category.toJson());
    return SizedBox(
      width: MySize.size18(context),
      child: Column(
        children: [
          GestureDetector(
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList(
                    id: (category.id??"").toString(),
                    name: category.name??"",
                  )
                )
              );
            },
            child: Container(
              width: MySize.size18(context),
              height: MySize.sizeh10(context),
              padding: EdgeInsets.symmetric(vertical: MySize.sizeh3(context), horizontal: MySize.size4(context)),
              decoration: BoxDecoration(
                  color: MyColors.colorCatBg,
                  border: Border.all(color: MyColors.colorCatBorder),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                    ),
                  ]
              ),
              child: Image.network(
                category.image?.src??"",
                fit: BoxFit.fill,
                errorBuilder: (BuildContext context, obj, stack) {
                  return const Icon(
                      Icons.category
                  );
                },
              ),
            ),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                (category.name??"").toUpperCase(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MySize.font10(context),
                    color: MyColors.black,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getExploreDesign(ProductData product, int index) {
    print(product.toJson());
    return SizedBox(
      width: MySize.size25(context),
      child: Column(
        children: [
          GestureDetector(
            onTap: ()
            {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => Products(
              //       id: category.id??"",
              //       name: category.name??"",
              //     )
              //   )
              // );
            },
            child: Container(
              width: MySize.size25(context),
              height: MySize.sizeh12(context),
              padding: EdgeInsets.symmetric(vertical: MySize.sizeh3(context), horizontal: MySize.size4(context)),
              margin: EdgeInsets.only(bottom: MySize.sizeh1(context)),
              decoration: BoxDecoration(
                  color: MyColors.white,
                  border: Border.all(color: MyColors.grey10),
              ),
              child: Image.network(
                product.images?[0]?.src??"",
                fit: BoxFit.fill,
                errorBuilder: (BuildContext context, obj, stack) {
                  return const Icon(
                      Icons.category
                  );
                },
              ),
            ),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                (product.name??"").toUpperCase(),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MySize.font10(context),
                    color: MyColors.black,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget getBestsellerDesign(RandomData random, int index) {
  //   return Container(
  //     width: MySize.size100(context),
  //     padding: EdgeInsets.all(MySize.size10(context)),
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(MySize.size5(context)),
  //         color: MyColors.white,
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey,
  //             blurRadius: 2,
  //           ),
  //         ]
  //     ),
  //     child: Column(
  //       children: [
  //         Image.network(
  //             Environment.imageUrl+(random.image??""),
  //             height: MySize.size80(context),
  //             fit: BoxFit.fill,
  //           ),
  //         Padding(
  //           padding: EdgeInsets.only(top: MySize.size10(context)),
  //           child: Text(
  //             random.title??"",
  //             overflow: TextOverflow.ellipsis,
  //             style: TextStyle(
  //               fontSize: MySize.font11(context),
  //               color: MyColors.black,
  //               fontWeight: FontWeight.w500
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(top: MySize.size2(context)),
  //           child: Text(
  //             "₹ "+(random.salePrice??""),
  //             style: TextStyle(
  //               fontSize: MySize.font12(context),
  //               color: MyColors.black,
  //               fontWeight: FontWeight.w500
  //             ),
  //           ),
  //         ),
  //         Container(
  //           height: MySize.size18(context),
  //           width: MySize.size100(context),
  //           padding: EdgeInsets.only(top: MySize.size5(context), left: MySize.size12(context), right: MySize.size12(context)),
  //           child: ElevatedButton(
  //               onPressed: () {
  //                 addToCart(index);
  //               },
  //               style: ButtonStyle(
  //                 backgroundColor: MaterialStateProperty.all(MyColors.colorAccent3),
  //               ),
  //               child: Text(
  //                 "ADD",
  //                 style: TextStyle(
  //                   fontSize: MySize.font12(context),
  //                   color: MyColors.black
  //                 ),
  //               ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // getDeliveryType() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   DeliveryTypeResponse deliveryTypeResponse = await APIService().getDeliveryType();
  //
  //   deliveryType = deliveryTypeResponse.status??true ? deliveryTypeResponse.data??[] : [];
  //   setState(() {
  //
  //   });
  //   getCategory();
  // }

  getCategory() async {
    CategoryResponse categoryResponse = await APIService().getCategories();

    category = categoryResponse.status??true ? categoryResponse.data??[] : [];
    getProduct();
  }


  getProduct() async {
    ProductListResponse productListResponse = await APIService().getProduct();
    product = productListResponse.status??true ? productListResponse.data??[] : [];

    load = true;
    setState(() {

    });
  }

  // Future<void> addToCart(int ind) async {
  //   Map<String,dynamic> data = {
  //     "access_token" : (sharedPreferences?.getString("token")??"").toString(),
  //     "product_id": bestseller[ind].productId??"",
  //     "crust_id": "",
  //     "size_id": "",
  //     "product_amount": bestseller[ind].salePrice??"",
  //     "toppings_amount": "",
  //     "toppings_id": "",
  //     "extra_cheese_amount" : "0"
  //   };
  //
  //   print(data);
  //   StatusResponse statusResponse = await APIService().addToCart(data);
  //   print(statusResponse.toJson());
  //
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text((statusResponse.status ?? false ? "Added to cart" ?? statusResponse?.message??"" : statusResponse?.message??""))));
  //
  // }

}
