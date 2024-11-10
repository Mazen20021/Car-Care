import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../Utilities/dto.dart';

class RepairApi with ChangeNotifier {
  bool loading = false;
  static bool hasError = false;
  String? error;
  bool isAuth = false;
  bool isLoggedIn = false;
  final DTO dto = DTO();
  final Dio api;
  final BuildContext context;

  RepairApi(this.context)
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

  Future<FetchRepairsResult> fetchRepairs() async {
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
      return FetchRepairsResult(success: false, repairs: [], error: e.response?.data.toString());
    } finally {
      await setLoading(false);
    }
  }

  FetchRepairsResult _parseFetchCarsResponse(Response response) {
    final repairsData = response.data['repairs'] ?? [];
    final repairList = (repairsData as List).map((item) => RepairType.fromJson(item)).toList();
    return FetchRepairsResult(success: repairList.isNotEmpty, repairs: repairList, error: null);
  }

  Future<void> createRepairList(RepairType repairs , String carID) async {
    try {
      final jsonData = repairs.toJson();
      await api.post(
        '/cars/$carID/repairs',
        data: jsonData,
        options: Options(
          headers: {"Authorization": "Bearer ${await dto.getToken()}"},
        ),
      );
      print("repair created successfully");
    } on DioError catch (e) {
      final errorResponse = e.response?.data['error'] ?? 'Unknown error';
      print("Failed to create repair: $errorResponse");
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
class FetchRepairsResult {
  final bool success;
  final List<RepairType> repairs;
  final String? error;

  FetchRepairsResult({required this.success, required this.repairs, this.error});
}
class RepairType {
  final String id;
  final String name;
  final String reminderKm;
  final String? profileId;

  RepairType({
    required this.id,
    required this.name,
    required this.reminderKm,
    this.profileId,
  });

  factory RepairType.fromJson(Map<String, dynamic> json) {
    return RepairType(
      id: json['id'],
      name: json['name'],
      reminderKm: json['reminder_km'],
      profileId: json['profileId'],
    );

  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'reminder_km': reminderKm,
      'profileId':profileId,
    };
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
              RepairApi.hasError = true;
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
