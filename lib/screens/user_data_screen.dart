import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constant.dart';
import 'package:expenz/widget/custom_button.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
// for the check box
  bool _rememberMe = false;

  // form key for the form validation
  final _formKey = GlobalKey<FormState>();

  //controller for the text from field
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passworldController = TextEditingController();
  final TextEditingController _confirmPasswordontroller = TextEditingController();
  
  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passworldController.dispose();
    _confirmPasswordontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Builder(
              builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Enter your \nPersonal details", 
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),),
                
                    SizedBox(height: 30,),
                    // form
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _userNameController,
                          validator: (value) {
                            // check wether the user enterde name
                            if (value!.isEmpty) {
                              return "Please enter the name please";
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: const EdgeInsets.all(20),                                                          
                          ),
                        ),
                        SizedBox(height: 15,),
                        // form of the email
                         TextFormField(
                          controller: _emailController,
                           validator: (value) {
                            // check wether the user enterde name
                            if (value!.isEmpty) {
                              return "Please enter the e-mail please";
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'E-mail',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: const EdgeInsets.all(20),                                                          
                          ),
                        ),
                        // form of the password
                         SizedBox(height: 15,),
                        
                         TextFormField(
                          controller: _passworldController,
                           validator: (value) {
                            // check wether the user enterde name
                            if (value!.isEmpty) {
                              return "Please enter the password please";
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: const EdgeInsets.all(20),                                                          
                          ),
                        ),
                         SizedBox(height: 15,),
                        // form of the cofirme plz password
                         TextFormField(
                          controller: _confirmPasswordontroller,
                           validator: (value) {
                            // check wether the user enterde name
                            if (value!.isEmpty) {
                              return "Please confirmed the password please";
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Confirm password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: const EdgeInsets.all(20),                                                          
                          ),
                        ),
                        SizedBox(height: 30,),
                        // remember me
                        Row(
                          children: [
                            Text("Remember me for the next time", 
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kGrey,
                            ),
                            ),

                            Expanded(child: CheckboxListTile(
                              activeColor: kMainColor,
                              value: _rememberMe, 
                              onChanged: (value){
                                setState(() {
                                  _rememberMe = value!;
                                });

                              },
                               ),
                              ), 
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        //Submit Button
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            //form is valid, process data
                            String userName = _userNameController.text;
                            String email = _emailController.text;
                            String password = _passworldController.text;
                            String confirmPassword = _confirmPasswordontroller.text; 
                          }
                        },
                        child: const CustomButton(
                          buttonName: "Next", 
                          buttonColor: kMainColor),
                      )
                      ],
                    ),
                    ),
                  ],
                );
              }
            ),
          ),),
      ),
    );
  }
}