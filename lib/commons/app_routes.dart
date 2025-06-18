import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:openvpn_client/client/binding/vpn_binding.dart';
import 'package:openvpn_client/client/widget/vpn_view.dart';
import 'package:openvpn_client/main.dart';
import 'package:openvpn_client/splash/binding/splash_binding.dart';
import 'package:openvpn_client/splash/widget/splash_view.dart';

class AppRoutes {
  static const String splashPage = '/splash_page';
  static const String vpnPage = '/vpn_page';


  static List<GetPage> pages = [
    GetPage(
        name: splashPage,
        page: () => SplashView(),
        bindings: [SplashBinding()]),
    GetPage(
        name: vpnPage,
        page: () => VpnView(),
        bindings: [VpnBinding()]),
  ];
}