import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:qii_assignment/model/news_model.dart';
import 'package:qii_assignment/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Apicalls {
  static bool isDeviceConnected = false;
  static late StreamSubscription subscription;
  static String resKey = 'RESPONSE';
  static bool checkConnectivity() {
    subscription = Connectivity().onConnectivityChanged.listen((result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
    });
    return isDeviceConnected;
  }

  static Future<News> getNews() async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    http.Response? res =
        checkConnectivity() ? await http.get(Uri.parse(fetchingUrl)) : null;
    if (res == null) {
      String resBody = sf.getString(resKey) ?? "";
      if (resBody == "") {
        return News(
            status: 'No Internet Connection',
            totalResults: -1,
            articles: [
              Article(
                  source: Source(
                      id: 'No Internet Connection',
                      name: 'No Internet Connection'),
                  author: 'No Internet Connection',
                  title: 'No Internet Connection',
                  description: 'No Internet Connection',
                  url: 'No Internet Connection',
                  urlToImage: 'No Internet Connection',
                  publishedAt: 'No Internet Connection',
                  content: 'No Internet Connection')
            ]);
      }
      log("from local storage");
      return News.fromJson(jsonDecode(resBody));
    } else if (res.statusCode == 200) {
      await sf.setString(resKey, res.body);
      return News.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
