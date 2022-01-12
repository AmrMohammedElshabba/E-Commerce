import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/componants/text_form_field.dart';
import 'package:e_commerce/network/cache_helper.dart';
import 'package:e_commerce/screens/home_layout/cubit/home_cubit.dart';
import 'package:e_commerce/screens/home_layout/cubit/home_states.dart';
import 'package:e_commerce/screens/home_layout/setting/edit_profile.dart';
import 'package:e_commerce/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constans.dart';
import 'change_password.dart';

class SettingPage extends StatelessWidget {
//  var formKey = GlobalKey<FormState>();
//  var userNameController = TextEditingController();
//  var emailController = TextEditingController();
//  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
//        userNameController.text = cubit.loginModel!.data!.name!;
//        emailController.text = cubit.loginModel!.data!.email!;
//        phoneController.text = cubit.loginModel!.data!.phone!;
        return ConditionalBuilder(
          condition: cubit != null,
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Settings",
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      context: context,
                      text: "Edit Profile",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditPage()));
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      context: context,
                      text: "Change Password",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePasswordPage()));
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Row(
                      children: [
                        Text("Dark Mode",
                            style: Theme.of(context).textTheme.bodyText2),
                        Spacer(),
                        Switch(activeColor: Colors.blue,value: cubit.darkMode, onChanged: (v){
                          cubit.changeAppMode();
                        })
                      ],
                    ),
                  ),

//                  TextButton(
//                      icon: Icon(Icons.dark_mode),
//                      context: context,
//                      text: "Dark Mode",
//                      onTap: () {
//                        cubit.changeAppMode();
//                      }),
                  SizedBox(
                    height: 200,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        cubit.Logout();
                        CacheHelper.removeData(key: "token").then((value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (route) => false);
                        });
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: defaultColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            Text(
                              "LOGOUT",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget TextButton(
          {context,
          String? text,
          required Function onTap,
          required Icon icon}) =>
      Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          children: [
            Text(text!, style: Theme.of(context).textTheme.bodyText2),
            Spacer(),
            IconButton(
              onPressed: () {
                onTap();
              },
              icon: icon,
              color: Colors.grey,
            )
          ],
        ),
      );
}
