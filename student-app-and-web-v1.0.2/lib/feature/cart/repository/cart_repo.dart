import 'dart:convert';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/feature/cart/model/cart_model.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cart_model_body.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  CartRepo({required this.sharedPreferences,required this.apiClient});

  List<CartModel> getCartList() {
    List<String> carts = [];
    if(sharedPreferences.containsKey(AppConstants.cartList)) {
      carts = sharedPreferences.getStringList(AppConstants.cartList)!;
    }
    List<CartModel> cartList = [];
    carts.forEach((cart) => cartList.add(CartModel.fromJson(jsonDecode(cart))) );
    return cartList;
  }

  void addToCartList(List<CartModel> cartProductList) {
    List<String> carts = [];
    for (var cartModel in cartProductList) {
      carts.add(jsonEncode(cartModel));
    }
    for (var element in cartProductList) {
      printLog(element.id);
    }

    sharedPreferences.setStringList(AppConstants.cartList, carts);
  }

  Future<Response> addToCartListToServer(CartModelBody cartModel) async {
    return await apiClient.postData(AppConstants.addToCart, cartModel.toJson());
  }

  Future<Response> getCartListFromServer() async {
    return await apiClient.getData(AppConstants.getCartList);
  }

  Future<Response> removeCartFromServer(String cartID) async {
    return await apiClient.deleteData("${AppConstants.deleteCartItem}$cartID");
  }

  Future<Response> removeAllCartFromServer() async {
    return await apiClient.deleteData(AppConstants.deleteAllCart);
  }

}