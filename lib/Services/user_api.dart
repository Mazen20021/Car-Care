import 'package:carcare/Pages/login_page.dart';
import 'package:carcare/Services/car_api.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../Utilities/dto.dart';
import 'mainpageservice.dart';

class UserAPI with ChangeNotifier {

  bool loading = false;
  static bool hasError = false;
  String? error;
  User? user;
  bool isAuth = false;
  bool isLoggedIn = false;
  final DTO dto = DTO();
  final Dio api;
  final BuildContext context;
  late CarAPI carApi ;

  UserAPI(this.context)
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
    carApi = CarAPI(context);
    await setLoading(true);
    try {
      final response = await api.get('/auth', options: Options(
          headers: {"Authorization": "Bearer ${await dto.getToken()}"}
      ));
      user = User.fromJson(response.data['user']);
      if (user != null) {
        carApi.fetchCars();
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
    carApi = CarAPI(context);
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
        carApi.fetchCars();
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
      final token = await dto.getToken();
      await api.put('/auth', data: userInfo.toJson(), options: Options(headers: {"Authorization": "Bearer $token"}),);
      user = userInfo;
      print("User Updated");
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
              UserAPI.hasError = true;
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
