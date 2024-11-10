import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../Utilities/dto.dart';

class CarAPI with ChangeNotifier {
  bool loading = false;
  static bool hasError = false;
  String? error;
  bool isAuth = false;
  bool isLoggedIn = false;
  final DTO dto = DTO();
  final Dio api;
  final BuildContext context;

  CarAPI(this.context)
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

  Future<void> deleteCars({required String carID}) async {
    await setLoading(true);
    try {
      final token = await dto.getToken();
      final response = await api.delete(
        '/cars/$carID',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      print("Car Deleted successfully");
    } on DioError catch (e) {
      logError(e);
    } finally {
      await setLoading(false);
    }
  }
  Future<void> updateCars({required String carID, required Cars car}) async {
    print("Car: $car");

    try {
      final token = await dto.getToken();
      final response = await api.put(
        '/cars/$carID',
        data: car.toMap(), // Use the toMap() function to pass the car data
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      print("Car updated successfully: $response");
    } on DioError catch (e) {
      logError(e);
    }
  }

  Future<FetchCarsResult> fetchCars() async {
    await setLoading(true);
    try {
      final token = await dto.getToken();
      final response = await api.get(
        '/cars',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return _parseFetchCarsResponse(response);
    } on DioError catch (e) {
      logError(e);
      return FetchCarsResult(success: false, cars: [], error: e.response?.data.toString());
    } finally {
      await setLoading(false);
    }
  }

  FetchCarsResult _parseFetchCarsResponse(Response response) {
    final carsData = response.data['cars'] ?? [];
    final carsList = (carsData as List).map((item) => Cars.fromJson(item)).toList();
    return FetchCarsResult(success: carsList.isNotEmpty, cars: carsList, error: null);
  }

  Future<void> createCar(Cars car) async {
    try {
      final jsonData = car.toJson();
      print("Request payload: $jsonData");  // Log to confirm structure

      await api.post(
        '/cars',
        data: jsonData,
        options: Options(
          headers: {"Authorization": "Bearer ${await dto.getToken()}"},
        ),
      );
      print("Car created successfully");
    } on DioError catch (e) {
      final errorResponse = e.response?.data['error'] ?? 'Unknown error';
      print("Failed to create car: $errorResponse");
      print("Status code: ${e.response?.statusCode}");
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
class FetchCarsResult {
  final bool success;
  final List<Cars> cars;
  final String? error;

  FetchCarsResult({required this.success, required this.cars, this.error});
}
class Cars {
  final String make;
  final String model;
  final String year;
  final String carClass;
  final String notifyme;
  final String profileID;
  final String led;
  final String ed;
  final int movedDistance;
  final String id;
  final List<dynamic> repairs;
  final List<dynamic> gas;
  Cars({
    required this.make,
    required this.model,
    required this.year,
    required this.carClass,
    required this.notifyme,
    required this.profileID,
    required this.led,
    required this.ed,
    required this.movedDistance,
    this.id ="",
    this.repairs = const [],
    this.gas = const [],
  });
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "make": make,
      "model": model,
      "year": year,
      "classId": carClass,
      "license_expiration_date": led,
      "examination_date": ed,
      "notify_every": notifyme,
      "km": movedDistance,
      "profileId": profileID,
      "repairs": repairs,
      "gas": gas,
    };
  }
  factory Cars.fromJson(Map<String, dynamic> json) {
    return Cars(
      make: json['make'] ?? '', // Use a default value if necessary
      model: json['model'] ?? '',
      year: json['year'].toString(), // Ensure year is a string
      carClass: json['classId'] ?? '', // Map to classId
      notifyme: json['notify_every'] ?? '', // Map to notify_every
      profileID: json['profileId'] ?? '', // Map to profileId
      led: json['license_expiration_date'] ?? '', // Assuming license expiration date
      ed: json['examination_date'] ?? '', // Assuming examination date
      movedDistance: json['km'],
      id:json['id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'make': make,
      'model': model,
      'year': year,
      'classId':carClass,
      'notify_every':notifyme,
      'profileId': profileID,
      'km' : movedDistance,
      'gas' : [],
      'repairs': []
    };
  }
}

class CarClass {
  final String id;
  final String name;

  CarClass({required this.id, required this.name});

  factory CarClass.fromJson(Map<String, dynamic> json) {
    return CarClass(
      id: json['id'],
      name: json['name'],
    );
  }
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
              CarAPI.hasError = true;
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
