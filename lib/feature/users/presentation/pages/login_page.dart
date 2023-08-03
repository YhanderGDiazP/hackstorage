import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hackstorage/feature/posts/presentation/pages/home_posts.dart';
import 'package:hackstorage/feature/posts/presentation/providers/post_provider.dart';
import 'package:hackstorage/feature/posts/presentation/providers/post_provider_offline.dart';
import 'package:hackstorage/feature/users/presentation/providers/user_provider.dart';
import 'package:hackstorage/feature/users/presentation/providers/user_provider_offline.dart';
import 'package:hackstorage/feature/users/presentation/widgets/elevate_bottom_customed.dart';
import 'package:hackstorage/feature/users/presentation/widgets/textformfield_custom.dart';
import 'package:hackstorage/settings/settings_provider.dart';
import 'package:hackstorage/settings/styles/colors_data.dart';
import 'package:hackstorage/settings/widgets/appbar_wg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final postProvider = Provider.of<PostProvider>(context);
    final postProviderOff = Provider.of<PostProviderOffline>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final userProviderOff = Provider.of<UserProviderOffline>(context);
    final settingProvider = Provider.of<SettingsProvider>(context);
    final keyFormLogin = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: ColrsData.black,
      appBar: WGAppBar().customAppBar(context, true),
      body: Center(
        child: Form(
          key: keyFormLogin,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'HACK',
                  style: TextStyle(
                    fontSize: 40,
                    color: ColrsData.white,
                    letterSpacing: 4,
                  ),
                ),
                const Text(
                  'STORAGE',
                  style: TextStyle(
                    fontSize: 30,
                    color: ColrsData.greyWhite,
                    letterSpacing: 10,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 60,
                  width: 300,
                  child: CustomTextFormField(
                    hintText: 'Usuario',
                    validate: (value) {
                      String pattern = r'^[a-zA-ZÁÉÍÓÚáéíóúüÜÑñ ]+$';
                      RegExp regex = RegExp(pattern);
                      if (value == null || value.isEmpty) {
                        return 'Escriba un usuario correcto';
                      } else if (!regex.hasMatch(value)) {
                        return 'Escriba un usuario correcto';
                      }
                      return null;
                    },
                    controller: userController,
                    obscureText: false,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 60,
                  width: 300,
                  child: CustomTextFormField(
                    hintText: 'Contraseña',
                    validate: (value) {
                      String pattern =
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$';
                      RegExp regex = RegExp(pattern);
                      if (value == null || value.isEmpty) {
                        return 'Minimo una minuscula, una mayuscula y un numero';
                      } else if (!regex.hasMatch(value)) {
                        return 'Minimo una minuscula, una mayuscula y un numero';
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: true,
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
                CustomElevateButtom(
                  label: 'Entrar',
                  onPressed: () async {
                    if (keyFormLogin.currentState!.validate()) {
                      bool userLogged;
                      if (settingProvider.connectivityResultGet !=
                          ConnectivityResult.none) {
                        userLogged = await userProvider.login(
                          userController.text,
                          passwordController.text,
                        );
                      } else {
                        userLogged = await userProviderOff.loginUser(
                          userController.text,
                          passwordController.text,
                        );
                      }
                      if (userLogged) {
                        settingProvider.connectivityResultGet !=
                                ConnectivityResult.none
                            ? postProvider.getAllPost()
                            : postProviderOff.getPosts();
                        showLoginSuccessDialog(context);
                      } else {
                        showLoginErrorDialog(context);
                      }
                    }
                  },
                  heigth: 60,
                  width: 300,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showLoginSuccessDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            'Éxito',
            style: TextStyle(color: Colors.white),
          ),
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 10),
              Text(
                'El usuario inició sesión con éxito.',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePostPage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void showLoginErrorDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            'Error',
            style: TextStyle(color: Colors.white),
          ),
          content: const Row(
            children: [
              Icon(Icons.error, color: Colors.red),
              SizedBox(width: 10),
              Text(
                'Credenciales Incorrectas,\n por favor vuelva a ingresarlos.',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
