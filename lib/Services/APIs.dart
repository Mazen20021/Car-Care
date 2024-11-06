import 'package:carcare/Pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../Utilities/dto.dart';
import 'mainpageservice.dart';

class AuthActions with ChangeNotifier {
  bool loading = false;
  static bool hasError = false;
  String? error;
  User? user;
  bool isAuth = false;
  bool isLoggedIn = false;
  final DTO dto = DTO();
  final Dio api;
  final BuildContext context;

  AuthActions(this.context)
      : api = Dio(BaseOptions(
    baseUrl: DTO.BACKEND_API,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<void> setLoading(bool value) async {
    loading = value;
    notifyListeners();
  }
  Future<void> navigateToMainPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPageService(
          profileID: user!.id.toString(),
          userName: user!.firstName.toString(),
          userEmail: user!.email.toString(),
          userLastName: user!.lastName.toString(),
          currentIndex: 0,
          costs: "",
          date: "",
          itemsNumber: 0,
          liters: "",
          petrolName: "",
        ),
      ),
    );
  }
  void logError(DioError e) {
    print("Error: ${e.response?.data ?? 'Unknown error'}");
    print("Status code: ${e.response?.statusCode ?? 'No Status Code'}");
    print("Dio error message: ${e.message}");
  }

  Future<void> authorization() async {
    await setLoading(true);
    try {
      final response = await api.get('/auth', options: Options(
          headers: {"Authorization": "Bearer ${await dto.getToken()}"}
      ));
      user = User.fromJson(response.data['user']);
      if (user != null) {
        fetchCars();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                 MainPageService(
                   profileID: user!.id.toString(),
                  userName: user!.firstName.toString(),
                  userEmail: user!.email.toString(),
                  userLastName: user!.lastName.toString(),
                  currentIndex: 0,
                  costs: "",
                  date: "",
                  itemsNumber: 0,
                  liters: "",
                  petrolName: "",
                )));
      }
      error = null;
    } on DioError catch (e) {
      user = null;
      error = e.response?.data['error'] ?? 'Failed to fetch user';
    } finally {
      await setLoading(false);
    }
  }

  Future<void> deleteAccount() async {
    await setLoading(true);
    try {
      final response = await api.delete('/auth', options: Options(
          headers: {"Authorization": "Bearer ${await dto.getToken()}"}
      ));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
      error = null;
    } on DioError catch (e) {
      user = null;
      error = e.response?.data['error'] ?? 'Failed to delete user';
    } finally {
      await setLoading(false);
    }
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    await setLoading(true);
    try {
      final response = await api.post('/auth/register', data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
      });
      user = User.fromJson(response.data['user']);
      error = null;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Login()));
      showCurrentDialog(context,
          "Successfully registered! confirmation mail was sent. Please Confirm your email");
    } on DioError catch (e) {
      error = e.response?.data['error'] ?? 'Failed to register';
      showErrorDialog(context, error!);
    } finally {
      await setLoading(false);
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await setLoading(true);
    try {
      final response = await api.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      final accessToken = response.data['session']?['access_token'];
      if (accessToken != null) {
        await dto.saveToken(accessToken);
        user = User.fromJson(response.data['user']);
        hasError = false;
        fetchCars();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
               MainPageService(

                 profileID: user!.id.toString(),
                userName: user!.firstName.toString(),
                 userEmail: user!.email.toString(),
                 userLastName: user!.lastName.toString(),
                currentIndex: 0,
                costs: "",
                date: "",
                itemsNumber: 0,
                liters: "",
                petrolName: "",
              )),
        );
        error = null;
      } else {
        hasError = true;
        throw Exception("Access token not found in response");
      }
    } on DioException catch (e) {
      hasError = true;
      error = e.response?.data['error'] ?? 'Failed to log in';
      print("Dio error data: ${e.response?.data}"); // Added for debugging
      print(
          "Dio error status: ${e.response?.statusCode}"); // Added for debugging
      showErrorDialog(context, "$error - ${e.response?.toString()}");
    } finally {
      await setLoading(false);
    }
  }


  Future<void> logout() async {
    await setLoading(true);
    try {
      await dto.deleteToken();
      user = null;
      error = null;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Login()),
      );
    } catch (e) {
      error = 'Failed to log out';
    } finally {
      await setLoading(false);
    }
  }

  Future<void> updateMe(User userInfo) async {
    await setLoading(true);
    try {
      await api.put('/auth', data: userInfo.toJson());
      user = userInfo;
      error = null;
    } on DioError catch (e) {
      error = e.response?.data['error'] ?? 'Failed to update user';
    } finally {
      await setLoading(false);
    }
  }

  Future<void> resetPassword(String email) async {
    await setLoading(true);
    try {
      await api.post('/auth/cars', data: {'email': email});
      error = null;
    } on DioError catch (e) {
      error = e.response?.data['error'] ?? 'Failed to send verification code';
      print("Error: $error");
    } finally {
      await setLoading(false);
    }
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
  Future<void> updateCars({required String carID , required Cars car}) async {
    try {
      final token = await dto.getToken();
      final response = await api.head(
        '/cars/$carID',
          data: {
        'Car': car,
      },
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      print("Car updated successfully$response");
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
  });
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

class RepairType {
  final String id;
  final String name;
  final int reminderKm;
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
}

class User {
  final String id;
  final String? firstName;
  final String? lastName;
  final String email;

  User({required this.id, this.firstName, this.lastName, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
  };
   String getUserID ()
  {
    return id;
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
              AuthActions.hasError = true;
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
