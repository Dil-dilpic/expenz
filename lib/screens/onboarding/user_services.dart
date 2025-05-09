import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  //methode to save username and email inshared preference
  static Future<void> storeUserDetails({
   required String userName,
   required String email,
   required String password,
   required String confirmPassword,
   required BuildContext context,
  }) async {
   
    // if the password and confim pasword are same thren store the username and email
    try {
       //check weather the user entered password and cofirm password
    if(password != confirmPassword) {
      //show a messege to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("password and confirmed Password not match"),
        ),

      );

      return;
    }
      //create an instance from shared pref
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //store the user name and email as key value pairs
      await prefs.setString("userName", userName);
      await prefs.setString("email", email);

      //show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar
      (content: Text("User Details stored successfully"),
      ),
      );
    } catch (err) {
      err.toString();
    }

  }

  // methode to check the user name is save the shared preferences
  static Future<bool> checkUsername() async {

    //create an instance fpr
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('userName');
    return userName != null;
  }

  // get the username and the email
  static Future<Map <String, String>> getUserData() async {
    //create an instance for shared preference
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? userName = pref.getString("userName");
    String? email = pref.getString("email");

    return {
      "userName" : userName!,
      "email" : email!,
    };
  } 
  // remove the username and email from shared preferences
  static Future<void> clearUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('userName');
    await pref.remove('email');
  }
}