import 'package:flutter/material.dart';
import 'package:shop24u/Screens/ProductDetails.dart';
import 'package:shop24u/api/APIConstant.dart';
import 'package:shop24u/api/APIService.dart';
import 'package:shop24u/api/Environment.dart';
import 'package:shop24u/colors/MyColors.dart';
import 'package:shop24u/model/ProductResponse.dart';
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

  @override
  void initState() {
    id = widget.id;
    name = widget.name;

    getProduct();
    super.initState();
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
                // Navigator.push(context, MaterialPageRoute(builder: (context) =>
                //     MyCart())
                // );
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
                    // if (validate() == 0) {
                    //   login();
                    // }
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

}
