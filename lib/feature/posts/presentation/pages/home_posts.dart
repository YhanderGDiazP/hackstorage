import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hackstorage/feature/posts/domain/entities/post_entity.dart';
import 'package:hackstorage/feature/posts/presentation/pages/create_post.dart';
import 'package:hackstorage/feature/posts/presentation/providers/post_provider.dart';
import 'package:hackstorage/feature/posts/presentation/providers/post_provider_offline.dart';
import 'package:hackstorage/feature/posts/presentation/widgets/post.dart';
import 'package:hackstorage/feature/users/domain/entities/user_entity.dart';
import 'package:hackstorage/feature/users/presentation/providers/user_provider.dart';
import 'package:hackstorage/feature/users/presentation/providers/user_provider_offline.dart';
import 'package:hackstorage/settings/settings_provider.dart';
import 'package:hackstorage/settings/styles/colors_data.dart';
import 'package:hackstorage/settings/widgets/appbar_wg.dart';
import 'package:provider/provider.dart';

class HomePostPage extends StatelessWidget {
  const HomePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context);
    final postProviderOff =
        Provider.of<PostProviderOffline>(context, listen: false);
    final userProviderOff = Provider.of<UserProviderOffline>(context);
    final settingProvider = Provider.of<SettingsProvider>(context);

    List<Post> listPost =
        settingProvider.connectivityResultGet != ConnectivityResult.none
            ? postProvider.listPruebaPost
            : postProviderOff.listPruebaPost;

    UserLogin? userLogged = settingProvider.connectivityResultGet !=
                                ConnectivityResult.none ? userProvider.userLogged : userProviderOff.userLogged;
                                
    return Scaffold(
      backgroundColor: ColrsData.black,
      appBar: WGAppBar().customAppBar(context, false),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
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
                  height: 20,
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: listPost.isEmpty
                      ? const Center(
                          child: Text(
                            'No hay contraseñas',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: listPost.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: listPost[index].idUser ==
                                      userLogged!.id
                                  ? PostGe(post: listPost[index])
                                  : null,
                            );
                          },
                        ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: ColrsData.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreatePost(),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: ColrsData.white, // Color del borde
                  width: 2, // Ancho del borde
                ),
              ),
              child: const Icon(
                Icons.add,
                color: ColrsData.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
