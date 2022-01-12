import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/componants/text_form_field.dart';
import 'package:e_commerce/network/cache_helper.dart';
import 'package:e_commerce/screens/home_layout/cubit/home_cubit.dart';
import 'package:e_commerce/screens/home_layout/cubit/home_states.dart';
import 'package:e_commerce/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constans.dart';

class EditPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        userNameController.text = cubit.loginModel!.data!.name!;
        emailController.text = cubit.loginModel!.data!.email!;
        phoneController.text = cubit.loginModel!.data!.phone!;
        return Scaffold(
          appBar: AppBar(
            title: Text("Edit Profile"),
          ),
          body: ConditionalBuilder(
            condition: cubit != null,
            builder: (context) => SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if (state is LoadingPutUserDataState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          prefix: Icons.person,
                          lable: "User Name",
                          keybordType: TextInputType.emailAddress,
                          validateText: "Input user name address",
                          controller: userNameController),
                      SizedBox(
                        height: 35,
                      ),
                      defaultFormField(
                          prefix: Icons.mail_outline,
                          lable: "Email",
                          keybordType: TextInputType.emailAddress,
                          validateText: "Input email address",
                          controller: emailController),
                      SizedBox(
                        height: 35,
                      ),
                      defaultFormField(
                          prefix: Icons.phone,
                          lable: "Phone",
                          keybordType: TextInputType.phone,
                          validateText: "Input your phone",
                          controller: phoneController),
                      SizedBox(
                        height: 70,
                      ),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            cubit.PutUserDate(
                                name: userNameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }
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
                                Icons.edit,
                                color: Colors.white,
                              ),
                              Text(
                                "Update",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
