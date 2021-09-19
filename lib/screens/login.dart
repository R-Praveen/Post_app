import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:posts_app/blocs/login_bloc.dart';
import 'package:posts_app/providers/repository_provider.dart';
import 'package:posts_app/screens/home.dart';
import 'package:posts_app/theme/colors.dart';
import 'package:posts_app/widgets/app_button.dart';
import 'package:posts_app/widgets/bordered_text_field.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const route = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<LoginBloc>(
      create: (BuildContext context) => LoginBloc(
        loginRepository: provideLoginRepository(),
      ),
      dispose: (_, bloc) => bloc.dispose(),
      child: const Login(),
    );
  }
}

class Login extends StatefulWidget {
  static const route = '/login';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginBloc? bloc;
  @override
  void didChangeDependencies() {
    if (bloc == null) {
      bloc = Provider.of<LoginBloc>(context);
      bloc?.loginUser.listen((bool value) {
        if (value) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Home.route,
            (Route<dynamic> route) => false,
          );
        }
      });
      bloc?.checkUserLoggedIn.listen((bool value) async {
        if (value) {
          await Navigator.of(context).pushNamedAndRemoveUntil(
            Home.route,
            (Route<dynamic> route) => false,
          );
        }
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in "),
        centerTitle: true,
        backgroundColor: AppColors.black,
        elevation: 0,
      ),
      backgroundColor: AppColors.black,
      body: StreamBuilder<bool>(
          stream: bloc?.checkUserLoggedIn,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!(snapshot.data ?? true)) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    BorderedTextField(
                      title: 'Email ID',
                      textStream: bloc?.email,
                      errorStream: bloc?.emailError,
                      onTextChanged: (String value) =>
                          bloc?.onEmailChanged(value),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    BorderedTextField(
                      title: 'Password',
                      textStream: bloc?.password,
                      errorStream: bloc?.passwordError,
                      obscureText: true,
                      onTextChanged: (String value) =>
                          bloc?.onPasswordChanged(value),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: AppButton(
                        child: const Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () async {
                          await bloc?.onClickContinue();
                        },
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return const SizedBox();
          }),
    );
  }
}
