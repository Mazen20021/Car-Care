import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class SignupService{
   Future<Map<String, dynamic>> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
     required BuildContext myContext,
  }) async {
    // Define the URL for the request
    const String url = 'https://carcareapi.elitesx.work/api/auth/register';

    // Prepare the body of the request
    final Map<String, String> body = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
    };
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if(response.statusCode > 299)
        {
          showErrorDialog(myContext , "Failed to register Status code: ${response.statusCode} ${response.body}");
          return {
            'user': null,
            'error': 'Failed to register. Status code: ${response.statusCode}',
          };
        }else{
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        showSuccessDialog(myContext);
        return {
          'user': responseData['user'],
          'error': null,
        };
      }


    } catch (error) {
      showErrorDialog(myContext , error.toString() );
      return {
        'user': null,
        'error': error.toString(),
      };
    }
  }
}
class LoginService{
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
    required BuildContext myContext,
  }) async {
    // Define the URL for the request
    const String url = 'https://carcareapi.elitesx.work/api/auth/login';

    // Prepare the body of the request
    final Map<String, String> body = {
      'email': email,
      'password': password,
    };
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if(response.statusCode > 299)
      {
        showErrorDialog(myContext , "Failed to register Status code: ${response.statusCode} ${response.body}");
        return {
          'user': null,
          'error': 'Failed to register. Status code: ${response.statusCode}',
        };
      }else{
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        String? accessToken = responseBody['session']['access_token'];
        localStorage.setItem("accessToken", accessToken!);
        return {
          'user': responseData['user'],
          'error': null,
        };
      }


    } catch (error) {
      showErrorDialog(myContext , error.toString() );
      return {
        'user': null,
        'error': error.toString(),
      };
    }
  }
}
class GetUserInfoService{
  static bool isAuth = false;

  Future<Map<String, dynamic>> auth({
    required BuildContext myContext,
  }) async {
    // Define the URL for the request
    const String url = 'https://carcareapi.elitesx.work/api/auth';

    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json',"Authorization" : "Bearer ${localStorage.getItem("accessToken")}"},
      );

      if(response.statusCode > 299)
      {
        isAuth = false;
        showErrorDialog(myContext , "Failed to register Status code: ${response.statusCode} ${response.body}");
        return {
          'user': null,
          'error': 'Failed to register. Status code: ${response.statusCode}',
        };
      }else{
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        showSuccessDialogx(myContext , localStorage.getItem("accessToken").toString());

        return {
          'user': responseData['user'],
          'error': null,
        };
      }


    } catch (error) {
      showErrorDialog(myContext , error.toString() );
      return {
        'user': null,
        'error': error.toString(),
      };
    }
  }
  void showSuccessDialogx(BuildContext context , String tx) {
    isAuth = true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text('You have successfully Logged in!$tx'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the success dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Success'),
        content: Text('You have successfully signed up!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the success dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

// Error dialog
void showErrorDialog(BuildContext context , String error ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text('Sign-up failed. Please try again.' + error ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the error dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
