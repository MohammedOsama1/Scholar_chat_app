import 'package:chat_app/cubit/cubit.dart';
import 'package:chat_app/cubit/states.dart';
import 'package:chat_app/themes.dart';
import 'package:chat_app/widgets/cusiome_txt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:toast/toast.dart';

import '../widgets/custome_button.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is RegisterErrorStates) {
          showToast(state.error, Colors.red);
          isLoading = false;
        }
        if (state is RegisterSucStates) {
          showToast('Register Successfully', Colors.green);
          isLoading = false;
          Navigator.pushNamedAndRemoveUntil(context, 'ChatScreen', (route) => false,arguments: emailController.text);

        }
        if (state is RegisterLoading) {
          isLoading = true;
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: primaryClr,
              elevation: 0,
            ),
            backgroundColor: primaryClr,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image1.png',
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'Scholar Chat',
                        style: primaryStyle,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hint: 'Email',
                        controller: emailController,
                        validator: (date) {
                          if (date!.isEmpty) {
                            return 'Can\'t be null';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          hint: 'Password',
                          isPass: cubit.isPass,
                          widget: IconButton(
                            onPressed: () {
                              cubit.showPassword();
                            },
                            icon: cubit.isPass
                                ? const Icon(Icons.lock)
                                : const Icon(Icons.lock_open),
                            color: Colors.white,
                          ),
                          controller: passController,
                          validator: (date) {
                            if (date!.isEmpty) {
                              return 'Can\'t be null';
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        text: 'Register',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            cubit.register(
                                emailController.text, passController.text);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: primaryStyle.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, 'LoginScreen');
                            },
                            child: Text(
                              'Login ',
                              style: primaryStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
