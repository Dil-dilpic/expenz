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
}