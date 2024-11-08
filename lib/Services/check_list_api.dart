import 'package:carcare/Pages/login_page.dart';
import 'package:carcare/Services/car_api.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../Utilities/dto.dart';
import 'mainpageservice.dart';

class CheckList with ChangeNotifier {

  bool loading = false;
  static bool hasError = false;
  String? error;
  bool isAuth = false;
  bool isLoggedIn = false;
  final DTO dto = DTO();
  final Dio api;
  final BuildContext context;
  late CarAPI carApi ;

  CheckList(this.context)
      : api = Dio(BaseOptions(
    baseUrl: DTO.BACKEND_API,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<void> setLoading(bool value) async {
    loading = value;
    notifyListeners();
  }
  void logError(DioError e) {
    print("Error: ${e.response?.data ?? 'Unknown error'}");
    print("Status code: ${e.response?.statusCode ?? 'No Status Code'}");
    print("Dio error message: ${e.message}");
  }

  Future<void> updateMe(CheckLists userInfo) async {
    await setLoading(true);
    try {
      final token = await dto.getToken();
      await api.put('/auth', data: userInfo.toJson(), options: Options(headers: {"Authorization": "Bearer $token"}),);

      error = null;
    } on DioError catch (e) {
      error = e.response?.data['error'] ?? 'Failed to update user';
    } finally {
      await setLoading(false);
    }
  }

  void showCurrentDialog(BuildContext context, String message, {bool isError = false}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isError ? 'Error' : 'Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

}


class CheckLists {
  final String name;
  final String kmLeft;
  final String? carID;
  final String? userID;

  CheckLists({required this.name, required this.kmLeft, this.carID, required this.userID});

  factory CheckLists.fromJson(Map<String, dynamic> json) {
    return CheckLists(
      userID: json['id'],
      name: json['name'],
      kmLeft: json['km'],
      carID: json['carId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': userID,
    'name': name,
    'km': kmLeft,
    'carId': carID,
  };
}

void showErrorDialog(BuildContext context, String error) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text('Operation failed. $error'),
        actions: [
          TextButton(
            onPressed: () {
              CheckList.hasError = true;
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
