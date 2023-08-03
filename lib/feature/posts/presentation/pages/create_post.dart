import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hackstorage/feature/posts/presentation/providers/post_provider.dart';
import 'package:hackstorage/feature/posts/presentation/providers/post_provider_offline.dart';
import 'package:hackstorage/feature/posts/presentation/widgets/elevate_bottom_customed.dart';
import 'package:hackstorage/feature/posts/presentation/widgets/textformfield_custom.dart';
import 'package:hackstorage/feature/users/presentation/providers/user_provider.dart';
import 'package:hackstorage/feature/users/presentation/providers/user_provider_offline.dart';
import 'package:hackstorage/settings/settings_provider.dart';
import 'package:hackstorage/settings/styles/colors_data.dart';
import 'package:hackstorage/settings/widgets/appbar_wg.dart';
import 'package:provider/provider.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userEmailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    final postProvider = Provider.of<PostProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final postProviderOff = Provider.of<PostProviderOffline>(context);
    final userProviderOff = Provider.of<UserProviderOffline>(context);
    final settingProvider = Provider.of<SettingsProvider>(context);
    final keyFormCreatePost = GlobalKey<FormState>();
    return Scaffold(
      appBar: WGAppBar().customAppBar(context, true),
      backgroundColor: ColrsData.black,
      body: Center(
        child: Form(
          key: keyFormCreatePost,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomPTextFormField(
                    hintText: 'Correo/Usuario',
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Debe tener un Correo o Usuario';
                      }
                      return null;
                    },
                    controller: userEmailController,
                    obscureText: false,
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomPTextFormField(
                    hintText: 'Contraseña',
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Debe tener una Contraseña';
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: true,
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomPTextFormField(
                    hintText: 'Descripción',
                    controller: descriptionController,
                    obscureText: false,
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
                CustomPElevateButtom(
                  label: 'Crear Contraseña',
                  onPressed: () async {
                    if (keyFormCreatePost.currentState!.validate()) {
                      bool postCreated;
                      if (settingProvider.connectivityResultGet !=
                          ConnectivityResult.none) {
                        postCreated = await postProvider.createPost(
                          userProvider.userLogged!.id,
                          userEmailController.text,
                          passwordController.text,
                          descriptionController.text,
                        );
                      } else {
                        postCreated = await postProviderOff.createPost(
                          userProviderOff.userLogged!.id,
                          userEmailController.text,
                          passwordController.text,
                          descriptionController.text,
                        );
                      }
                      if (postCreated) {
                        showPasswordSavedDialog(context);
                      } else {
                        showPasswordSaveErrorDialog(context);
                      }
                    }
                  },
                  heigth: 75,
                  width: 300,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showPasswordSavedDialog(BuildContext context) {
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
                'La contraseña fue guardada \n con éxito.',
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
              },
            ),
          ],
        );
      },
    );
  }

  void showPasswordSaveErrorDialog(BuildContext context) {
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
                'Hubo un error al tratar de \n guardar la contraseña.',
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
