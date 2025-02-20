import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guessit_task/SQLite/sqLite.dart';
import 'package:guessit_task/jsonsModels/users.dart';
import 'package:guessit_task/screens/HomeScreen.dart';
import 'package:guessit_task/screens/SignUp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  State<LoginScreen> createState() => _LoginScreenState();

}
 class _LoginScreenState extends State<LoginScreen>{

  //we need two editing controller
  final email=TextEditingController();
  final password =TextEditingController();
  bool isVisible=false;
  //to create global key for our form
  final formKey =GlobalKey<FormState>();
  final db  =DatabaseHelper();
  bool isLoginTrue=false;


  Login() async {
    var response = await db.login(Users(email: email.text, userPassword: password.text));
     if (response == true) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 55.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // يخلي النصوص يمين
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
                        textAlign: TextAlign.center, // يضبط المحاذاة في السنتر
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
                      borderSide: BorderSide(color: Color(0xFFC4C4C4)), // حافة عند التركيز
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14,vertical: 16),
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
                  obscureText: !isVisible,
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
                       isVisible =!isVisible;
                     });
                    }, icon:Icon(isVisible
                        ? Icons.visibility
                        :Icons.visibility_off_sharp
                    ),iconSize: 16,color: Colors.grey,),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFFC4C4C4)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14,vertical: 16),

                  ),
                ),
                const SizedBox(height: 10),

                // Forgot Password
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                    },
                    child: const Text(
                      'هل نسيت كلمة المرور؟',
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'alexandria',
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF878787)
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

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
                          print("Email:${email.text},password:${password.text}");
                          Login();
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



                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUpScreen()));
                          },
                          child: Text('إنشاء حساب جديد',
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'alexandria',
                               fontWeight: FontWeight.w400,
                                color: Color(0xFF333333)

                              )
                          )),
                      Text('ليس لديك حساب؟',
                        style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'alexandria',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF878787)
                        ),
                      ),
                    ],
                  ),

                ),
                isLoginTrue
                    ? Center(
                  child: Text(
                    "البريد الالكتروني او كلمه المرور خاطئه",
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'alexandria',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}