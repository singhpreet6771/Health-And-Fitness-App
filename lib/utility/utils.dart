import 'package:connectivity/connectivity.dart';
class Utils{

  static String UID = "";
  static Future<bool> isInternetConnected () async {



    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    }
    else{
      return false;

    }
  }
}