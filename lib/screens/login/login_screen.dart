import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/componants/show_toast.dart';
import 'package:e_commerce/componants/text_form_field.dart';
import 'package:e_commerce/network/cache_helper.dart';
import 'package:e_commerce/screens/home_layout/cubit/home_cubit.dart';
import 'package:e_commerce/screens/home_layout/cubit/home_states.dart';
import 'package:e_commerce/screens/home_layout/home_layout.dart';
import 'package:e_commerce/screens/login/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constans.dart';

class LoginPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build (BuildContext context) {
    return
      BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.status!) {
            CacheHelper.saveData(
                    key: "token", value: state.loginModel.data!.token)
                .then((value) {
              print(state.loginModel.data!.token);
              token = state.loginModel.data!.token!;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeLayout()),
                  (route) => false);
            });
          } else {
            print(state.loginModel.message);
            ShowToast(state.loginModel.message!);
          }
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: const Image(
                        image: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Login to continue',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: defaultFormField(
                          prefix: Icons.mail_outline,
                          lable: "Email",
                          keybordType: TextInputType.emailAddress,
                          validateText: "Input email address",
                          controller: emailController),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: defaultFormField(
                          prefix: Icons.lock_outline,
                          lable: "Password",
                          keybordType: TextInputType.visiblePassword,
                          validateText: "Input email address",
                          controller: passwordController,
                          obsecureText: cubit.isPassword,
                          sufix: cubit.suffixIcon,
                          sufixPressed: () {
                            cubit.ShowPassword();
                          }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                      condition: State is! LoadingLoginState,
                      builder: (context) => InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            cubit.UserLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 1.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: defaultColor),
                          child:  Center(
                            child: Text(
                              "LOGIN",
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          'don\'t have an account?',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
                        ),
                        TextButton(
                          child: Text(
                            'create a new account',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: defaultColor),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()) );
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
