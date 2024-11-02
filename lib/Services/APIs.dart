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
  final DTO dto = DTO();  // Replace with your token management logic
  final Dio api = Dio(BaseOptions(
    baseUrl: DTO.BACKEND_API,
    connectTimeout: const Duration(seconds: 5),  // 5 seconds
    receiveTimeout: const Duration(seconds: 3),  // 3 seconds
  ));

  static bool isAuth = false;
  static bool isLoggedIn = false;
  final BuildContext context;

  AuthActions(this.context);

  Future<void> setLoading(bool value) async {
    loading = value;
    notifyListeners();
  }

  Future<void> me() async {
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
                builder: (context) => const MainPageService(
                  isCarSelected: true,
                  userName: "Mazen",
                  currentIndex: 0,
                  costs: "",
                  date:"",
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
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
      showSuccessDialog(context, "Successfully registered! confirmation mail was sent. Please Confirm your email");
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
              builder: (context) => const MainPageService(
                isCarSelected: true,
                userName: "Mazen",
                currentIndex: 0,
                costs: "",
                date:"",
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
      print("Dio error status: ${e.response?.statusCode}"); // Added for debugging
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
      await api.post('/auth/reset-password', data: {'email': email});
      error = null;
      print("Verification code sent to $email");
    } on DioError catch (e) {
      error = e.response?.data['error'] ?? 'Failed to send verification code';
      print("Error: $error");
    } finally {
      await setLoading(false);
    }
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
