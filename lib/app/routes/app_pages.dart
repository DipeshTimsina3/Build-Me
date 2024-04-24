import 'package:get/get.dart';

import '../modules/ChangePassword/bindings/change_password_binding.dart';
import '../modules/ChangePassword/views/change_password_view.dart';
import '../modules/EditUser/bindings/edit_user_binding.dart';
import '../modules/EditUser/views/edit_user_view.dart';
import '../modules/admin_categories/bindings/admin_categories_binding.dart';
import '../modules/admin_categories/views/admin_categories_view.dart';
import '../modules/admin_dashboard/bindings/admin_dashboard_binding.dart';
import '../modules/admin_dashboard/views/admin_dashboard_view.dart';
import '../modules/admin_main/bindings/admin_main_binding.dart';
import '../modules/admin_main/views/admin_main_view.dart';
import '../modules/admin_orders/bindings/admin_orders_binding.dart';
import '../modules/admin_orders/views/admin_orders_view.dart';
import '../modules/admin_products/bindings/admin_products_binding.dart';
import '../modules/admin_products/views/admin_products_view.dart';
import '../modules/admin_users/bindings/admin_users_binding.dart';
import '../modules/admin_users/views/admin_users_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/detail_category/bindings/detail_category_binding.dart';
import '../modules/detail_category/views/detail_category_view.dart';
import '../modules/detailed_product/bindings/detailed_product_binding.dart';
import '../modules/detailed_product/views/detailed_product_view.dart';
import '../modules/favourite/bindings/favourite_binding.dart';
import '../modules/favourite/views/favourite_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/myThriftProduct/bindings/my_thrift_product_binding.dart';
import '../modules/myThriftProduct/views/my_thrift_product_view.dart';
import '../modules/my_detail_thrift_product/bindings/my_detail_thrift_product_binding.dart';
import '../modules/my_detail_thrift_product/views/my_detail_thrift_product_view.dart';
import '../modules/myproducts/bindings/myproducts_binding.dart';
import '../modules/myproducts/views/myproducts_view.dart';
import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/thrift/bindings/thrift_binding.dart';
import '../modules/thrift/views/thrift_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const LOGIN = Routes.LOGIN;
  static const HOME = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => const OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_MAIN,
      page: () => const AdminMainView(),
      binding: AdminMainBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_DASHBOARD,
      page: () => const AdminDashboardView(),
      binding: AdminDashboardBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PRODUCTS,
      page: () => const AdminProductsView(),
      binding: AdminProductsBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_CATEGORIES,
      page: () => const AdminCategoriesView(),
      binding: AdminCategoriesBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_ORDERS,
      page: () => const AdminOrdersView(),
      binding: AdminOrdersBinding(),
    ),
    GetPage(
      name: _Paths.DETAILED_PRODUCT,
      page: () => const DetailedProductView(),
      binding: DetailedProductBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_USERS,
      page: () => const AdminUsersView(),
      binding: AdminUsersBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_CATEGORY,
      page: () => const DetailCategoryView(),
      binding: DetailCategoryBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.THRIFT,
      page: () => const ThriftView(),
      binding: ThriftBinding(),
    ),
    GetPage(
      name: _Paths.FAVOURITE,
      page: () => const FavouriteView(),
      binding: FavouriteBinding(),
      children: [
        GetPage(
          name: _Paths.FAVOURITE,
          page: () => const FavouriteView(),
          binding: FavouriteBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.MYPRODUCTS,
      page: () => const MyproductsView(),
      binding: MyproductsBinding(),
    ),
    GetPage(
      name: _Paths.MY_THRIFT_PRODUCT,
      page: () => const MyThriftProductView(),
      binding: MyThriftProductBinding(),
    ),
    GetPage(
      name: _Paths.MY_DETAIL_THRIFT_PRODUCT,
      page: () => const MyDetailThriftProductView(),
      binding: MyDetailThriftProductBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_USER,
      page: () => const EditUserView(),
      binding: EditUserBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
  ];
}
