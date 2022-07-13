
import 'Environment.dart';

class APIConstant {

  static String login = "login";
  static String signup = Environment.url + Environment.api + "customer-signup";
   static String categories = Environment.url + Environment.api + "fetch-category";
   static String newArrival = Environment.url + Environment.api + "latest-product";
   static String products = Environment.url + Environment.api + "fetch-product";
   static String categoryProduct = Environment.url + Environment.api + "product-by-category";
   static String similarProduct = Environment.url + Environment.api + "related-product";
   static String product = Environment.url + Environment.api + "view-single-product";
   static String addCart = Environment.url + Environment.api + "add-to-cart";
   static String viewCart = Environment.url + Environment.api + "view-cart";
   static String deliveryType = Environment.url + Environment.api + "api-delivery-type";
   static String subCatResponse = Environment.url + Environment.api + "api-product-list";
   static String checkProductAvail = Environment.url + Environment.api + "product-availability-check";
   static String size = Environment.url + Environment.api + "api-size-array";
   static String crust = Environment.url + Environment.api + "api-crust-array";
   static String cheese = Environment.url + Environment.api + "api-extra-cheese";
   static String vegtoppings = Environment.url + Environment.api + "api-vegtoppings";
   static String nonvegtoppings = Environment.url + Environment.api + "api-nonvegtoppings";
   static String profile = Environment.url + Environment.api + "api-view-profile";
   static String updateProfile = Environment.url + Environment.api + "api-update-profile";
   static String deliveryAddress = Environment.url + Environment.api + "api-fetch-address";
   static String updateCart = Environment.url + Environment.api + "api-update-cart";
   static String deleteCart = Environment.url + Environment.api + "api-delete-cart";
   static String addAddress = Environment.url + Environment.api + "api-add-address";
   static String insertOrder = Environment.url + Environment.api + "api-insert-order";
   static String myOrder = Environment.url + Environment.api + "api-order-history";

}
