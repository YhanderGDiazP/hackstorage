// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hackstorage/feature/users/presentation/pages/login_page.dart';
import 'package:hackstorage/feature/users/presentation/providers/user_provider.dart';
import 'package:hackstorage/feature/users/presentation/providers/user_provider_offline.dart';
import 'package:hackstorage/feature/users/presentation/widgets/elevate_bottom_customed.dart';
import 'package:hackstorage/feature/users/presentation/widgets/textformfield_custom.dart';
import 'package:hackstorage/settings/settings_provider.dart';
import 'package:hackstorage/settings/styles/colors_data.dart';
import 'package:hackstorage/settings/widgets/appbar_wg.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController verificatePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingsProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final userProviderOff = Provider.of<UserProviderOffline>(context);

    final keyFormRegister = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: ColrsData.black,
      appBar: WGAppBar().customAppBar(context, true),
      body: Center(
        child: Form(
          key: keyFormRegister,
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
                  height: 50,
                ),
                SizedBox(
                  height: 60,
                  width: 300,
                  child: CustomTextFormField(
                    hintText: 'Nombre',
                    validate: (value) {
                      String pattern = r'^[a-zA-ZÁÉÍÓÚáéíóúüÜÑñ ]+$';
                      RegExp regex = RegExp(pattern);
                      if (value == null || value.isEmpty) {
                        return 'Escriba un nombre correcto';
                      } else if (!regex.hasMatch(value)) {
                        return 'Escriba un nombre correcto';
                      }
                      return null;
                    },
                    controller: nameController,
                    obscureText: false,
                  ),
                ),
                const SizedBox(
                  height: 25,
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
                  height: 25,
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
                  height: 25,
                ),
                SizedBox(
                  height: 60,
                  width: 300,
                  child: CustomTextFormField(
                    hintText: 'Verifica la Contraseña',
                    validate: (value) {
                      String pattern =
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$';
                      RegExp regex = RegExp(pattern);
                      if (value == null || value.isEmpty) {
                        return 'Minimo una minuscula, una mayuscula y un numero';
                      } else if (!regex.hasMatch(value)) {
                        return 'Minimo una minuscula, una mayuscula y un numero';
                      } else if (passwordController.text !=
                          verificatePasswordController.text) {
                        return 'Las contraseñas no coinciden';
                      }
                      return null;
                    },
                    controller: verificatePasswordController,
                    obscureText: true,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                CustomElevateButtom(
                  label: 'Registrar',
                  onPressed: () async {
                    if (keyFormRegister.currentState!.validate()) {
                      bool userRegistered;
                      if (settingProvider.connectivityResultGet !=
                          ConnectivityResult.none) {
                        userRegistered = await userProvider.registerUser(
                          nameController.text,
                          userController.text,
                          passwordController.text,
                        );
                      } else {
                        userRegistered = await userProviderOff.registerUser(
                          nameController.text,
                          userController.text,
                          passwordController.text,
                        );
                      }
                      if (userRegistered) {
                        showSuccessDialog(context);
                      } else {
                        showErrorDialog(context);
                      }
                    }
                  },
                  heigth: 60,
                  width: 300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSuccessDialog(BuildContext context) {
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
                'El usuario se creó con éxito.',
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
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context) {
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
                'Hubo un error al crear el usuario.',
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
