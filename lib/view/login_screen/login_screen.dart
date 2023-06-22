import 'package:flutter/material.dart';
import 'package:recipely/utils/bloc_global/bloc_global.dart';
import 'package:recipely/viewmodel/login_screen/bloc_login_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  late BlocLoginScreen bloc;

  @override
  Widget build(BuildContext context) {
    // INIT BLOC
    bloc = BlocLoginScreen(context: context);

    /// ANIMATING LOGO
    bloc.eventSink.add(EnumsLoginScreen.animate);
    // SCAFFOLD
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.white,
      body: _body(context),
    );
  }

  _appBar() {
    return AppBar(
      title: const Text(
        'Login',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  Widget _body(BuildContext context) {
    return StreamBuilder<Object>(
        stream: bloc.stateStream,
        builder: (context, snapshot) {
          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Column(
              children: [
                _inputFields('email'),
                _inputFields('password'),
                _loginButton(),
                _forgotPassword(),
                const Spacer(),
                _socialButtons(),
              ],
            ),
          );
        });
  }

  _inputFields(String type) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      curve: Curves.ease,
      width: bloc.viewModel.emailPasswordBoxWidth,
      // width: blocGlobal!.viewModel!.deviceWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                type.contains('email') ? 'Email Address' : 'Password',
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: type.contains('email')
                  ? bloc.emailController
                  : bloc.passwordController,
              obscureText: type.contains('password') ? true : false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: Icon(type.contains('email')
                      ? Icons.email_outlined
                      : Icons.lock_outline),
                  suffixIcon: Icon(type.contains('email')
                      ? null
                      : Icons.remove_red_eye_outlined),
                  hintText: type.contains('email')
                      ? "Enter Email Address"
                      : 'Enter Password'),
            )
          ],
        ),
      ),
    );
  }

  _loginButton() {
    return bloc.viewModel.isLoading
        ? Container(
            margin:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: const CircularProgressIndicator(),
          )
        : AnimatedContainer(
            duration: const Duration(seconds: 2),
            curve: Curves.ease,
            margin:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            width: bloc.viewModel.loginButtonWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.black,
            ),
            child: ElevatedButton(
              onPressed: () {
                bloc.eventSink.add(EnumsLoginScreen.login);
              },
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
  }

  _forgotPassword() {
    return const Text(
      'Forgot Password?',
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
    );
  }

  _socialButtons() {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      curve: Curves.ease,
      width: bloc.viewModel.socialButtonsWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'or continue with',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              width: blocGlobal!.viewModel!.deviceWidth!,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.redAccent,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.g_mobiledata_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    'Login with Google',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              width: blocGlobal!.viewModel!.deviceWidth!,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.blueAccent,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.g_mobiledata_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    'Login with Facebook',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
