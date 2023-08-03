// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hackstorage/feature/posts/domain/entities/post_entity.dart';
import 'package:hackstorage/feature/posts/presentation/pages/update_post.dart';
import 'package:hackstorage/feature/posts/presentation/providers/post_provider.dart';
import 'package:hackstorage/feature/posts/presentation/providers/post_provider_offline.dart';
import 'package:hackstorage/settings/settings_provider.dart';
import 'package:hackstorage/settings/styles/colors_data.dart';
import 'package:provider/provider.dart';

class PostGe extends StatelessWidget {
  final Post post;
  const PostGe({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(166, 41, 41, 41), // Gris claro
        border: Border.all(
          color: Colors.white, // Bordes blancos
          width: 2.0, // Ancho del borde
        ),
        borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  post.id,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 233, 102, 102),
                    fontSize: 15,
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 30,
                    color: ColrsData.white,
                  ),
                  onSelected: (String result) {
                    if (result == 'Actualizar Post') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdatePost(post: post),
                        ),
                      );
                    } else if (result == 'Eliminar Post') {
                      customShowDialog(context);
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Actualizar Post',
                      child: Text('Actualizar Post'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Eliminar Post',
                      child: Text('Eliminar Post'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(
              left: 40.0,
              top: 10,
              bottom: 10,
            ),
            child: Text(
              'Usurario o Correo:        ${post.user}',
              style: const TextStyle(
                color: ColrsData.white,
                fontSize: 15,
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(
              left: 40.0,
              top: 10,
              bottom: 10,
            ),
            child: Text(
              'Contraseña:        ${post.password}',
              style: const TextStyle(
                color: ColrsData.white,
                fontSize: 15,
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(
              left: 40.0,
              top: 10,
              bottom: 15,
            ),
            child: Text(
              'Descripción: ${post.description}',
              style: const TextStyle(
                color: ColrsData.white,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> customShowDialog(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    final postProviderOff =
        Provider.of<PostProviderOffline>(context, listen: false);
    final settingProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    return showDialog(
      context: context,
      barrierDismissible: false, // No se puede cerrar al tocar fuera
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            'Eliminar contraseña',
            style: TextStyle(color: Colors.red),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Icon(Icons.warning, color: Colors.yellow, size: 60),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    '¿Estás seguro de que quieres eliminar esta contraseña?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el AlertDialog
              },
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () async {
                try {
                  bool postDelete;

                  if (settingProvider.connectivityResultGet !=
                      ConnectivityResult.none) {
                    postDelete = await postProvider.deletePost(post.id);
                  } else {
                    print('entro');
                    postDelete = await postProviderOff.deletePost(post.id);
                    print(postDelete);
                  }

                  if (postDelete) {
                    showPasswordDeletedDialog(context);
                  } else {
                    showPasswordDeleteErrorDialog(context);
                  }
                } catch (e) {
                  throw Exception('Hubo un error a la hora de eliminarlo.');
                }
                Navigator.of(context).pop(); // Cierra el AlertDialog
              },
              child: const Text(
                'Confirmar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void showPasswordDeletedDialog(BuildContext context) {
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
                'La contraseña fue eliminada con éxito.',
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

  void showPasswordDeleteErrorDialog(BuildContext context) {
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
                'Hubo un error al tratar de eliminar la contraseña.',
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
