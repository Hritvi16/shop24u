import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop24u/LoginPopUp.dart';
import 'package:shop24u/Screens/Login.dart';
import 'package:shop24u/Screens/MyCart.dart';
import 'package:shop24u/api/APIService.dart';
import 'package:shop24u/api/Environment.dart';
import 'package:shop24u/colors/MyColors.dart';
import 'package:shop24u/model/ProductResponse.dart';
import 'package:shop24u/model/Response.dart';
import 'package:shop24u/size/MySize.dart';

class ProductDetails extends StatefulWidget {
  final String id, name;
  const ProductDetails({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String id = "";
  String name = "";
  bool load = false;
  ProductData product = ProductData();
  List<ProductData> similar = [];

  List<Widget> slideShow = [];
  int qty = 1;

  final CarouselController _controller = CarouselController();
  int _current = 0;
  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    id = widget.id;
    name = widget.name;

    start();
    super.initState();
  }

  start() async {
    sharedPreferences = await SharedPreferences.getInstance();

    getProductDetails();
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
            padding: EdgeInsets.symmetric(vertical: MySize.sizeh3(context), horizontal: MySize.size5(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getImages(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: MySize.sizeh1(context)),
                    child: Text(
                      product.name??"",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: MySize.font16(context)
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: MySize.sizeh2(context)),
                    child: Text(
                      "${Environment.rupee} ${product.price??""}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: MySize.font23(context)
                      ),
                    ),
                  ),
                  getQuantityDesign(),
                  getDetailsDesign(),
                  getActionDesign(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: MySize.sizeh2(context)),
                    child: Center(
                      child: Text(
                        "SIMILAR PRODUCTS",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: MySize.font20(context)
                        ),
                      ),
                    ),
                  ),
                  getSimilarProductDesignBody()
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

  getSimilarProductDesignBody() {
    return Container(
      color: MyColors.grey10,
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: similar.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: MySize.size02(context),
            mainAxisSpacing: MySize.sizeh02(context),
            mainAxisExtent: MySize.sizeh30(context)
        ),
        itemBuilder: (BuildContext ctx, index) {
          return getSimilarProductDesign(similar[index], index);
        },
      ),
    );
  }

  getSimilarProductDesign(ProductData product, int index) {
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

  getImages() {
    return Padding(
      padding: EdgeInsets.only(bottom: MySize.sizeh2(context)),
      child: Column(
        children: [
          CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  height: 170,
                  initialPage: 0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              items: slideShow),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: slideShow.asMap().entries.map((entry) {
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    margin: EdgeInsets.symmetric(vertical: MySize.sizeh1(context), horizontal: MySize.size05(context)),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  getProductDetails() async {
    Map<String, dynamic> data = {
      "id" : id
    };
    print(data);

    ProductResponse productResponse = await APIService().getProductDetails(data);
    product = productResponse.status??true ? productResponse.data??ProductData() : ProductData();

    getRelatedProducts();
  }

  getRelatedProducts() async {
    Map<String, dynamic> data = {
      "related_ids" : id
    };
    print(data);

    ProductListResponse productListResponse = await APIService().getSimilarProduct(data);
    similar = productListResponse.status??true ? productListResponse.data??[] : [];

    print("hehh");
    setState(() {

    });
    fetchImages();
  }

  Future<void> fetchImages() async {
    int len = product?.images?.length??0;
    for (int i = 0; i < len; i++) {
      slideShow.add(
        ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              //padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                    ),
                  ]),
              child: Image.network(
                  product.images?[i].src??"",
                  fit: BoxFit.fill,
                  width: 1000,
                errorBuilder: (BuildContext context, obj, stack) {
                  return const Icon(
                      Icons.category
                  );
                },
              ),
            )),
      );
    }

    load = true;
    setState(() {

    });
  }

  getQuantityDesign() {
    return Padding(
      padding: EdgeInsets.only(bottom: MySize.sizeh1(context)),
      child: Row(
        children: [
          Text(
            "Quantity",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: MySize.font18(context)
            ),
          ),
          Container(
            height: MySize.sizeh5(context),
            margin: EdgeInsets.only(left: MySize.size5(context)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MySize.sizeh1(context)),
                border: Border.all(color: MyColors.grey10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    if(qty!=1) {
                      qty = qty - 1;

                      setState(() {

                      });
                    }
                  },
                  child: Container(
                    height: MySize.sizeh5(context),
                    decoration: BoxDecoration(
                      border: Border(right: BorderSide(color: MyColors.grey10)),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: MySize.size3(context)),
                      child: Icon(
                        Icons.remove,
                        color: qty!=1 ? MyColors.black : MyColors.grey30,
                        size: MySize.size6(context),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MySize.size5(context)),
                  child: Text(
                    qty.toString(),
                    style: TextStyle(
                        fontSize: MySize.font18(context),
                        color: MyColors.black
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    qty = qty + 1;

                    setState(() {

                    });
                  },
                  child: Container(
                    height: MySize.sizeh5(context),
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: MyColors.grey10)),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: MySize.size3(context)),
                      child: Icon(
                        Icons.add,
                        color: MyColors.black,
                        size: MySize.size6(context),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  getDetailsDesign() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MySize.sizeh3(context)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: MySize.sizeh4(context), horizontal: MySize.size7(context)),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.all(Radius.circular(MySize.sizeh1(context))),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
            ),
          ]
        ),
        child: Column(
          children: [
            getDescriptionDesign("Type", product.type??"", true),
            getDescriptionDesign("Capacity", product.type??"", true),
            getDescriptionDesign("Volt", product.type??"", true),
            getDescriptionDesign("Size", (product.dimensions?.length??"0")+" x "+(product.dimensions?.height??"0")+" x "+(product.dimensions?.width??"0"), true),
            getDescriptionDesign("Color", product.type??"", false),
          ],
        ),
      ),
    );
  }

  getDescriptionDesign(String title, String data, bool pad) {
    return Padding(
      padding: EdgeInsets.only(bottom: pad ? MySize.sizeh3(context) : 0),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              title+": ",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: MySize.font16(context)
              ),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Text(
              data,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: MySize.font16(context)
              ),
            ),
          ),
        ],
      ),
    );
  }

  getActionDesign() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MySize.sizeh1(context)),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SizedBox(
              height: MySize.sizeh6(context),
              child: ElevatedButton(
                  onPressed: () {
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
                        fontSize: MySize.font14(context)
                    ),
                  )
              ),
            ),
          ),
          SizedBox(
            width: MySize.size3(context),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SizedBox(
              height: MySize.sizeh6(context),
              child: ElevatedButton(
                  onPressed: () {
                    print("hello");
                    // if (validate() == 0) {
                    //   login();
                    // }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyColors.colorBuyNow),
                  ),
                  child: Text(
                    "BUY NOW",
                    style: TextStyle(
                        color: MyColors.white,
                        fontSize: MySize.font14(context)
                    ),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

  addToCart(ProductData product) async {
    Map<String, dynamic> data = {
      "customer_id" : sharedPreferences.getString("id"),
      "product_id" : id,
      "product_name" : product.name??"",
      "qty" : qty.toString(),
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
