import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop24u/LoginPopUp.dart';
import 'package:shop24u/Screens/Login.dart';
import 'package:shop24u/Screens/MyCart.dart';
import 'package:shop24u/Screens/ProductDetails.dart';
import 'package:shop24u/api/APIConstant.dart';
import 'package:shop24u/api/APIService.dart';
import 'package:shop24u/api/Environment.dart';
import 'package:shop24u/colors/MyColors.dart';
import 'package:shop24u/model/ProductResponse.dart';
import 'package:shop24u/model/Response.dart';
import 'package:shop24u/size/MySize.dart';

class ProductList extends StatefulWidget {
  final String id, name;
  const ProductList({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  String id = "";
  String name = "";
  bool load = false;
  List<ProductData> product = [];

  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    id = widget.id;
    name = widget.name;

    super.initState();
  }

  start() async {
    sharedPreferences = await SharedPreferences.getInstance();

    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: MyColors.colorPrimary,
        title:Text(
          name,
          style: TextStyle(
            color: MyColors.black,
            fontSize: MySize.font16(context)
          ),
        ),
        iconTheme:IconThemeData(color: MyColors.black),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: MySize.size3(context)),
            child: GestureDetector(
              onTap: () {

              },
              child: Icon(
                Icons.search,
                color: Colors.black,
                size: MySize.sizeh4(context),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: MySize.size2(context)),
            child: GestureDetector(
              onTap: () {
                if(sharedPreferences?.getString("status") == "logged in") {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>
                      MyCart())
                  );
                }
                else {
                  loginPopUp();
                }
              },
              child: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black,
                size: MySize.sizeh4(context),
              ),
            ),
          ),
        ],
      ),
      body: load ? SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: MySize.sizeh3(context)),
            child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: MySize.sizeh2(context), right: MySize.size5(context), left: MySize.size5(context)),
                    child: Image.asset(
                      "assets/banner/cbanner.png",
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: MySize.sizeh20(context),
                    ),
                  ),
                  getProductBody(),
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

  getProductBody() {
    return Container(
      color: MyColors.grey10,
      child: GridView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: product.length,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: MySize.size02(context),
            mainAxisSpacing: MySize.sizeh02(context),
            mainAxisExtent: MySize.sizeh30(context)
          ),
          itemBuilder: (BuildContext ctx, index) {
            return getProductDesign(product[index], index);
          },
      ),
    );
  }

  getProductDesign(ProductData product, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(
              id: (product.id??"").toString(),
              name: product.name??"",
            )
          )
        );
      },
      child: Container(
        color: MyColors.white,
        padding: EdgeInsets.symmetric(horizontal: MySize.size5(context), vertical: MySize.sizeh2(context)),
        child: Column(
          children: [
            Container(
              height: MySize.sizeh10(context),
              padding: EdgeInsets.only(bottom: MySize.sizeh2(context)),
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: MySize.sizeh1(context)),
              child: Text(
                product.name??"",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: MySize.font13(context)
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: MySize.sizeh1(context)),
              child: Text(
                "${Environment.rupee} ${product.price??""}",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: MySize.font15(context)
                ),
              ),
            ),
            Container(
              height: MySize.sizeh3_5(context),
              margin: EdgeInsets.only(top: MySize.sizeh1(context), right: MySize.size3(context), left: MySize.size3(context)),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () {
                    print("hello");
                    if(sharedPreferences?.getString("status") == "logged in") {
                      addToCart(product);
                    }
                    else {
                      loginPopUp();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyColors.colorSecondary),
                  ),
                  child: Text(
                    "ADD TO CART",
                    style: TextStyle(
                        color: MyColors.white,
                      fontSize: MySize.font11(context)
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  getProduct() async {
    Map<String, dynamic> data = {
      "cat_id" : id
    };

    ProductListResponse productListResponse = await APIService().getCategoryProduct(data);
    product = productListResponse.status??true ? productListResponse.data??[] : [];
    // product.addAll(productResponse.data??[]);
    // product.addAll(productResponse.data??[]);
    // product.addAll(productResponse.data??[]);
    load = true;
    setState(() {

    });
  }


  addToCart(ProductData product) async {
    Map<String, dynamic> data = {
      "customer_id" : sharedPreferences.getString("id"),
      "product_id" : product.id??"",
      "product_name" : product.name??"",
      "qty" : "1",
      "amount" : product.price??"0",
      "product_image" : (product.images?.length??0)>0 ? product?.images![0].src??"" : "",
    };
    print(data);

    Response response = await APIService().addToCart(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response.data??"")));

  }

  loginPopUp() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return LoginPopUp();
      },
    ).then((value) {
      if(value=="login")
        logout();
    });
  }

  Future<void> logout() async {
    sharedPreferences?.setString("status", "logged out");
    sharedPreferences?.setString("id", "");
    sharedPreferences?.setString("name", "");
    sharedPreferences?.setString("email", "");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Login()),
            (Route<dynamic> route) => false
    );
  }


}
