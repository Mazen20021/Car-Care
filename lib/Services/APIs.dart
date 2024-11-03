import 'package:carcare/Pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../Utilities/dto.dart';
import 'mainpageservice.dart';

class AuthActions with ChangeNotifier {
  static bool loading = false;
  static bool hasError = false;
  String? error;
  static User? user;
  final DTO dto = DTO(); // Replace with your token management logic
  final Dio api = Dio(BaseOptions(
    baseUrl: DTO.BACKEND_API,
    connectTimeout: const Duration(seconds: 5), // 5 seconds
    receiveTimeout: const Duration(seconds: 5), // 3 seconds
  ));

  static bool isAuth = false;
  static bool isLoggedIn = false;
  final BuildContext context;

  AuthActions(this.context);

  Future<void> setLoading(bool value) async {
    loading = value;
    notifyListeners();
  }

  Future<void> authorization() async {
    await setLoading(true);
    try {
      final response = await api.get('/auth', options: Options(
          headers: {"Authorization": "Bearer ${await dto.getToken()}"}
      ));
      user = User.fromJson(response.data['user']);
      if (user != null) {
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
      showSuccessDialog(context,
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

  Future<FetchCarsResult> fetchCars() async {
    await setLoading(true);
    try {
      final token = await dto.getToken();
      print("here1");
      final response = await api.get(
        '/cars',
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );
print("here");
      // Extract the data from the response
      final carsData = response.data['cars'] ?? [];
      final carClasses = response.data['carClasses'] ?? [];
      final repairTypes = response.data['repairTypes'] ?? [];

      // Parse the cars list
      final carsList = (carsData as List).map((item) => Cars.fromJson(item)).toList();
      final carClassesList = (carClasses as List).map((item) => CarClass.fromJson(item)).toList();
      final repairTypesList = (repairTypes as List).map((item) => RepairType.fromJson(item)).toList();

      final success = carsList.isNotEmpty;
      print(success ? "Cars list has data: ${carsList.length} items" : "Cars list is empty.");

      return FetchCarsResult(success: success, cars: carsList, error: null);
    } on DioException catch (e) {
      final errorResponse = e.response?.data ?? 'Unknown error'; // Log the whole response
      final statusCode = e.response?.statusCode ?? 'No Status Code'; // Log status code
      print("Failed to fetch cars: $errorResponse");
      print("Status code: $statusCode");
      print("Dio error message: ${e.message}"); // Print the specific error message

      return FetchCarsResult(success: false, cars: [], error: errorResponse.toString());
    } finally {
      await setLoading(false);
    }
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
  Cars({
    required this.make,
    required this.model,
    required this.year,
    required this.carClass,
    required this.notifyme,
    required this.profileID,
    required this.led,
    required this.ed,
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
      'km' : "0",
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

// Helper functions for success and error dialogs
void showSuccessDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              AuthActions.hasError = false;
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
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
