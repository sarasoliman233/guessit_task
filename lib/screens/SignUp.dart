import 'package:flutter/material.dart';
import 'package:guessit_task/SQLite/sqLite.dart';
import 'package:guessit_task/jsonsModels/users.dart';

import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget{
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  //we need two editing controller
  final email =TextEditingController();
  final password =TextEditingController();
  final confirmPassword =TextEditingController();
  final db  =DatabaseHelper();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  final formKey =GlobalKey<FormState>();
  signUp()async{
    var res = await db.signup(Users(email: email.text, userPassword: password.text));
    if(res>0){
      if(!mounted)return;
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 48.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo + Title
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 90,
                        height: 68,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'مرحبا بك في يوان',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'alexandria',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333)
                        ),

                      ),
                      SizedBox(height: 7),
                      Text(
                        'تسجيل دخول لمتجر يوان',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'alexandria',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF878787)
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),

                // Email Label
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'البريد الإلكتروني',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'alexandria',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF333333)
                    ),
                  ),
                ),
                SizedBox(height: 8),

                // Email Field
                TextFormField(
                  controller: email,
                  validator: (value){
                    if(value!.isEmpty){
                      return "يرجي ادخال البريد الالكتروني";
                    }
                    return null;
                  },
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'أدخل البريد الإلكتروني الخاص بك',
                    hintStyle: TextStyle(
                        fontSize: 13,
                        fontFamily: 'alexandria',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF878787)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFC4C4C4)),

                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFFC4C4C4)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                  ),
                ),
                const SizedBox(height: 20),

                // Password Label
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'كلمة المرور',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'alexandria',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF333333)
                    ),
                  ),
                ),
                SizedBox(height: 8),

                // Password Field
                TextFormField(
                  controller: password,
                  validator: (value){
                    if(value!.isEmpty){
                      return "يرجي ادخال كلمه المرور";
                    }
                    return null;
                  },
                  obscureText: isPasswordVisible,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'أدخل كلمة المرور الخاصة بك',
                    hintStyle: TextStyle(
                        fontSize: 13,
                        fontFamily: 'alexandria',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF878787)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFC4C4C4)),
                    ),
                    prefixIcon: IconButton(onPressed: (){
                      setState(() {
                        isPasswordVisible =!isPasswordVisible;
                      });
                    }, icon:Icon(isPasswordVisible
                        ? Icons.visibility_off_sharp
                        :Icons.visibility
                    ),iconSize: 16,color: Colors.grey,),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFFC4C4C4)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'تاكيد كلمة المرور',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'alexandria',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF333333)
                    ),
                  ),
                ),
                SizedBox(height: 8),

                // Password Field
                TextFormField(
                  controller: confirmPassword,
                  validator: (value){
                    if(value!.isEmpty){
                      return "يرجي ادخال كلمه المرور";
                    }else if(password.text != confirmPassword.text){
                      return "كلمات المرور غير متطابقه";
                    }
                    return null;
                  },
                  obscureText: isConfirmPasswordVisible,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'أدخل كلمة المرور الخاصة بك',
                    hintStyle: TextStyle(
                        fontSize: 13,
                        fontFamily: 'alexandria',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF878787)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFC4C4C4)),

                    ),
                    prefixIcon: IconButton(onPressed: (){
                      setState(() {
                        isConfirmPasswordVisible =!isConfirmPasswordVisible;
                      });
                    }, icon:Icon(isConfirmPasswordVisible
                        ? Icons.visibility_off_sharp
                        :Icons.visibility
                    ),iconSize: 16,color: Colors.grey,),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFFC4C4C4)), // حافة عند التركيز
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14,),
                  ),
                ),
                const SizedBox(height: 10),

                // Forgot Password

                const SizedBox(height: 55),

                // Login Button
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 172,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF25D27),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          final db=DatabaseHelper();
                          db.signup(Users(email: email.text, userPassword: password.text)).whenComplete((){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                          });
                        }
                      },
                      child: const Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'alexandria',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFFFFFF)
                        ),
                      ),
                    ),
                  ),
                ),



                // Sign up prompt
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      TextButton(
                          onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> const LoginScreen()));
                          },
                          child: Text('تسجيل دخول',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'alexandria',
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF333333)

                              )
                          )),
                      Text('لديك حساب؟',
                        style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'alexandria',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF878787)
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}




