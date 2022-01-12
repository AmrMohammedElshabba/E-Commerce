import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/componants/text_form_field.dart';
import 'package:e_commerce/screens/home_layout/cubit/home_cubit.dart';
import 'package:e_commerce/screens/home_layout/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constans.dart';


class ChangePasswordPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var currentPassController = TextEditingController();
  var newPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is ChangePassSuccessState){
          if(state.changePasswordModel.status!){
            Fluttertoast.showToast(
                msg: state.changePasswordModel.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Change Password"),
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
                      if (state is LoadingChangePassState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          prefix: Icons.lock,
                          lable: "Current Password",
                          keybordType: TextInputType.visiblePassword,
                          validateText: "Input cuttent password",
                          controller: currentPassController,
                          obsecureText: cubit.isPassword,
                          sufix: cubit.suffixIcon,
                          sufixPressed: () {
                            cubit.ShowPassword();
                          }

                      ),
                      SizedBox(
                        height: 35,
                      ),
                defaultFormField(
                    prefix: Icons.lock,
                    lable: "New Password",
                    keybordType: TextInputType.visiblePassword,
                    validateText: "Input new password",
                    controller: newPassController,
                    obsecureText: cubit.isPassword,
                    sufix: cubit.suffixIcon,
                    sufixPressed: () {
                      cubit.ShowPassword();
                    }

                ),
                      SizedBox(
                        height: 70,
                      ),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            cubit.ChangePassword(currentPass: currentPassController.text, newpassword: newPassController.text);
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: defaultColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              Text(
                                "Change Password",
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
