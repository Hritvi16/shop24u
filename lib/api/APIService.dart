import 'dart:convert';
import 'package:shop24u/model/CategoryResponse.dart';
import 'package:shop24u/model/ProductResponse.dart';
import 'package:shop24u/model/SignUpResponse.dart';

import 'APIConstant.dart';
import 'package:http/http.dart' as http;

class APIService {
  // Future<LoginResponse> login(Map<String, dynamic> data) async {
  //   String url = APIConstant.login;
  //   var result = await http.post(Uri.parse(url), body: data);
  //   var response = jsonDecode(result.body);
  //   LoginResponse loginResponse = LoginResponse.fromJson(response);
  //   return loginResponse;
  // }
  //
  Future<SignUpResponse> signup(Map<String, dynamic> data) async {
    String url = APIConstant.signup;
    var result = await http.post(Uri.parse(url), body: data);
    // print(result.body);
    var response = jsonDecode(result.body);
    SignUpResponse signUpResponse = SignUpResponse.fromJson(response);
    return signUpResponse;
  }

  Future<CategoryResponse> getCategories() async {
    String url = APIConstant.categories;
    var result = await http.get(Uri.parse(url));
    var response = jsonDecode(result.body);
    CategoryResponse categoryResponse = CategoryResponse.fromJson(response);
    return categoryResponse;
  }

  Future<ProductListResponse> getProduct() async {
    String url = APIConstant.products;
    var result = await http.get(Uri.parse(url));
    var response = jsonDecode(result.body);
    ProductListResponse productListResponse = ProductListResponse.fromJson(response);
    return productListResponse;
  }

  Future<ProductListResponse> getCategoryProduct(Map<String, dynamic> data) async {
    String url = APIConstant.categoryProduct;
    var result = await http.post(Uri.parse(url), body: data);
    var response = jsonDecode(result.body);
    ProductListResponse productListResponse = ProductListResponse.fromJson(response);
    return productListResponse;
  }

  Future<ProductResponse> getProductDetails(Map<String, dynamic> data) async {
    String url = APIConstant.product;
    print(url);
    var result = await http.post(Uri.parse(url), body: data);
    var response = jsonDecode(result.body);
    print("response");
    print(response);
    ProductResponse productResponse = ProductResponse.fromJson(response);
    return productResponse;
  }
  //
  // Future<SubCatResponse> getSubCategories(Map<String, dynamic> data) async {
  //   String url = APIConstant.subCatResponse;
  //   var result = await http.post(Uri.parse(url), body: data);
  //   var response = jsonDecode(result.body);
  //   SubCatResponse subCatResponse = SubCatResponse.fromJson(response);
  //   return subCatResponse;
  // }
  //
  // Future<ProductResponse> getProduct(Map<String, dynamic> data) async {
  //   String url = APIConstant.product;
  //   var result = await http.post(Uri.parse(url), body: data);
  //   var response = jsonDecode(result.body);
  //   ProductResponse product = ProductResponse.fromJson(response);
  //   return product;
  // }
  //
  // Future<SizeCrustResponse> getSize() async {
  //   String url = APIConstant.size;
  //   var result = await http.get(Uri.parse(url));
  //   var response = jsonDecode(result.body);
  //   SizeCrustResponse sizeResponse = SizeCrustResponse.fromJson(response);
  //   return sizeResponse;
  // }
  //
  // Future<SizeCrustResponse> getCrust() async {
  //   String url = APIConstant.crust;
  //   var result = await http.get(Uri.parse(url));
  //   var response = jsonDecode(result.body);
  //   SizeCrustResponse crustResponse = SizeCrustResponse.fromJson(response);
  //   return crustResponse;
  // }
  //
  // Future<ToppingsResponse> getCheese() async {
  //   String url = APIConstant.cheese;
  //   var result = await http.get(Uri.parse(url));
  //   var response = jsonDecode(result.body);
  //   ToppingsResponse toppingsResponse = ToppingsResponse.fromJson(response);
  //   return toppingsResponse;
  // }
  //
  // Future<ToppingsResponse> getVegToppings() async {
  //   String url = APIConstant.vegtoppings;
  //   var result = await http.get(Uri.parse(url));
  //   var response = jsonDecode(result.body);
  //   ToppingsResponse toppingsResponse = ToppingsResponse.fromJson(response);
  //   return toppingsResponse;
  // }
  // Future<ToppingsResponse> getNonVegToppings() async {
  //   String url = APIConstant.nonvegtoppings;
  //   var result = await http.get(Uri.parse(url));
  //   var response = jsonDecode(result.body);
  //   ToppingsResponse toppingsResponse = ToppingsResponse.fromJson(response);
  //   return toppingsResponse;
  // }
  //
  // Future<ProfileResponse> getProfile(Map<String, dynamic> data) async {
  //   String url = APIConstant.profile;
  //   var result = await http.post(Uri.parse(url), body: data);
  //   var response = jsonDecode(result.body);
  //   ProfileResponse profileResponse = ProfileResponse.fromJson(response);
  //   return profileResponse;
  // }
  //
  // Future<StatusResponse> updateProfile(Map<String, dynamic> data) async {
  //   String url = APIConstant.updateProfile;
  //   print(url);
  //   var result = await http.post(Uri.parse(url), body: data);
  //   var response = jsonDecode(result.body);
  //   StatusResponse statusResponse = StatusResponse.fromJson(response);
  //   return statusResponse;
  // }
  //
  // Future<AddressResponse> getDeliveryAddress(Map<String, dynamic> data) async {
  //   String url = APIConstant.deliveryAddress;
  //   var result = await http.post(Uri.parse(url), body: data);
  //   var response = jsonDecode(result.body);
  //   AddressResponse addressResponse = AddressResponse.fromJson(response);
  //   return addressResponse;
  // }
  //
  // Future<StatusResponse> addToCart(Map<String, dynamic> data) async {
  //   String url = APIConstant.addCart;
  //   var result = await http.post(Uri.parse(url), body: data);
  //   var response = jsonDecode(result.body);
  //   StatusResponse statusResponse = StatusResponse.fromJson(response);
  //   return statusResponse;
  // }
  //
  // Future<CartResponse> getCart(Map<String, dynamic> data) async {
  //   String url = APIConstant.viewCart;
  //   var result = await http.post(Uri.parse(url), body: data);
  //   var response = jsonDecode(result.body);
  //   CartResponse cartResponse = CartResponse.fromJson(response);
  //   return cartResponse;
  // }
  //
  // Future<StatusResponse> updateCart(Map<String, dynamic> data) async {
  //   String url = APIConstant.updateCart;
  //   print(url);
  //   var result = await http.post(Uri.parse(url), body: data);
  //   var response = jsonDecode(result.body);
  //   StatusResponse statusResponse = StatusResponse.fromJson(response);
  //   return statusResponse;
  // }
  //
  // Future<StatusResponse> deleteCart(Map<String, dynamic> data) async {
  //   String url = APIConstant.deleteCart;
  //   print(url);
  //   var result = await http.post(Uri.parse(url), body: data);
  //   var response = jsonDecode(result.body);
  //   StatusResponse statusResponse = StatusResponse.fromJson(response);
  //   return statusResponse;
  // }
  //
  // Future<StatusResponse> addAddress(Map<String, dynamic> data) async {
  //   String url = APIConstant.addAddress;
  //   var result = await http.post(Uri.parse(url), body: data);
  //   var response = jsonDecode(result.body);
  //   StatusResponse statusResponse = StatusResponse.fromJson(response);
  //   return statusResponse;
  // }
  //
  // Future<StatusResponse> insertOrder(Map<String, dynamic> data) async {
  //   String url = APIConstant.insertOrder;
  //   var result = await http.post(Uri.parse(url), body: data);
  //   var response = jsonDecode(result.body);
  //   StatusResponse statusResponse = StatusResponse.fromJson(response);
  //   return statusResponse;
  // }
  //
  // Future<OrderResponse> myOrder(Map<String, dynamic> data) async {
  //   String url = APIConstant.myOrder;
  //   var result = await http.post(Uri.parse(url), body: data);
  //   var response = jsonDecode(result.body);
  //   OrderResponse orderResponse = OrderResponse.fromJson(response);
  //   return orderResponse;
  // }
  //
  // Future<ProductAvail> productAvailable(Map<String, dynamic> data) async {
  //   String url = APIConstant.checkProductAvail;
  //   var result = await http.post(Uri.parse(url), body: data);
  //   var response = jsonDecode(result.body);
  //   ProductAvail productAvail = ProductAvail.fromJson(response);
  //   return productAvail;
  // }


}









