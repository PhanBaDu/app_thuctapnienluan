import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/data/provider/api_validator.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/cart/model/cart_model.dart';
import 'package:get_lms_flutter/feature/cart/model/cart_model_body.dart';
import 'package:get_lms_flutter/feature/cart/repository/cart_repo.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';

class CartController extends GetxController implements GetxService {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  List<CartModel> _cartList = [];
  List<CartModel> _initialCartList = [];
  bool _isLoading = false;
  double _amount = 0.0;
  bool _isOthersInfoValid = false;
  double _totalPrice = 0;
  bool _isButton = false;

  List<CartModel> get cartList => _cartList;
  List<CartModel> get initialCartList => _initialCartList;
  double get amount => _amount;
  bool get isLoading => _isLoading;
  bool get isOthersInfoValid => _isOthersInfoValid;
  double get totalPrice => _totalPrice;
  bool get isButton => _isButton;

  @override
  void onInit() {
    if (Get.find<AuthController>().isLoggedIn()) {
      getCartListFromServer();
    } else {
      getCartData();
    }
    super.onInit();
  }

  Future<List<CartModel>> getCartData() async{
    _isLoading = false;
    _cartList = [];
    _cartList.addAll(cartRepo.getCartList());
    for (var cart in _cartList) {
      _amount = _amount + (cart.discountedPrice * cart.quantity);
    }
    _isLoading = false;
    _cartTotalCost();
    update();
    return _cartList;

  }

  _cartTotalCost() {
    _totalPrice = 0.0;
    for (var cartModel in _cartList) {
      _totalPrice = _totalPrice + (cartModel.totalCost * cartModel.quantity) ;
    }
  }

  Future<void> getCartListFromServer()async{
    _isLoading = true;
    Response response = await cartRepo.getCartListFromServer();
    if(response.statusCode == 200){
      _cartList = [];
      response.body['data']['data'].forEach((cart){
        _cartList.add(CartModel.fromJson(cart));
      });
    } else{
      ApiValidator.validateApi(response);
    }

    _totalPrice = 0.0;
    double _couponDiscount = 0.0;
    _cartList.forEach((cartModel) {
      _totalPrice = _totalPrice + cartModel.totalCost;
      _couponDiscount = _couponDiscount + cartModel.couponDiscountPrice;
    });


    _isLoading = false;
    update();
  }

  Future<void> removeCartFromServer(String cartID)async{
    _isLoading = true;
    Response response = await cartRepo.removeCartFromServer(cartID);
    if(response.statusCode == 200){
      getCartListFromServer();
    }
    _isLoading = false;
    update();
  }


  Future<void> removeAllCartItem()async{
    Response response = await cartRepo.removeAllCartFromServer();
    printLog("inside_removeAllCartItem");
    printLog(response.statusCode);
    if(response.statusCode == 200){
      _isLoading = false;
      getCartListFromServer();
    }
  }



  void removeFromCartVariation(CartModel? cartModel) {
    if(cartModel == null) {
      _initialCartList = [];
    }else{
      _initialCartList.remove(cartModel);
      update();
    }
  }

  void removeFromCartList(int cartIndex) {
    _cartList[cartIndex].quantity = _cartList[cartIndex].quantity - 1;
    update();
  }

  void updateQuantity(int index, bool isIncrement) {
    if(isIncrement){
      _initialCartList[index].quantity += 1;
    }else{
      if(_initialCartList[index].quantity > -1) {
        _initialCartList[index].quantity -= 1;
      }
    }
    _isButton = _isQuantity();

    update();

  }

 bool _isQuantity( ) {
    int count = 0;
    for (var cart in _initialCartList) {
      count += cart.quantity;
    }
    return count > 0;
  }


  void setQuantity(bool isIncrement, CartModel cart) {
    int index = _cartList.indexWhere((element) => element == cart);
    if (isIncrement) {
      _cartList[index].quantity = _cartList[index].quantity + 1;
      _amount = _amount + _cartList[index].discountedPrice;
    } else {
      _cartList[index].quantity = _cartList[index].quantity - 1;
      _amount = _amount - _cartList[index].discountedPrice;
    }
    cartRepo.addToCartList(_cartList);

    _cartTotalCost();

    update();
  }

  void removeFromCart(int index) {
    _amount = _amount - (_cartList[index].discountedPrice * _cartList[index].quantity);
    _cartList.removeAt(index);
    cartRepo.addToCartList(_cartList);
    update();
  }


  void clearCartList() {
    _cartList = [];
    _amount = 0;
    cartRepo.addToCartList(_cartList);
    update();
  }

  void addDataToCart(){
    cartRepo.addToCartList(_replaceCartList());
    _cartTotalCost();
    update();
    getLMSToast("course_added_to_cart".tr,Colors.green);
    Get.back();
  }

  Future<void> addMultipleCartToServer() async {
    _isLoading = true;
    update();
    _replaceCartList();

    // await cartRepo.removeAllCartFromServer();
    if(_cartList.isNotEmpty){
      for (int index=0; index<_cartList.length;index++){
        await addToCartApi(_cartList[index]);
      }
    }
    _isLoading = false;
    getLMSToast("course_added_to_cart".tr,Colors.green);
    clearCartList();
    update();
  }

  Future<void> addToCartApi(CartModel cartModel)async{
    printLog("inside_addToCartApi");
     await cartRepo.addToCartListToServer(CartModelBody(
      courseId:cartModel.course!.id.toString(),
    ));
  }


  void removeAllAndAddToCart(CartModel cartModel) {
    _cartList = [];
    _cartList.add(cartModel);
    _amount = cartModel.discountedPrice * cartModel.quantity;
    cartRepo.addToCartList(_cartList);
    update();
  }

  int isAvailableInCart(CartModel cartModel, Course service) {
    int _index = -1;
    _cartList.forEach((cart) {
      if(cart.course != null){

      }
    });
    return _index;
  }



  setInitialCartList(Course course) {
    _initialCartList = [];


    CartModel cartModel = CartModel(
        course.id!.toString(),
        course.id!.toString(),
        course.categoryId!,
        course.subCategoryId!.toString(),
        course.price.toString(),
        1, '0', '0', '0', '0',
        course.price.toString(),
        course
    );

    int _index =  isAvailableInCart(cartModel, course);

    if(_index != -1) {
      cartModel.copyWith(id: _cartList[_index].id, quantity: _cartList[_index].quantity);
    }
    _initialCartList.add(cartModel);

    _isButton = false;
  }

  List<CartModel> _replaceCartList() {
    _initialCartList.removeWhere((_cart) => _cart.quantity < 1);

    _initialCartList.forEach((_initCart) {
      _cartList.removeWhere((cart) => cart.id.contains(_initCart.id));
    });
    _cartList.addAll(_initialCartList);
    return _cartList;
  }

}
