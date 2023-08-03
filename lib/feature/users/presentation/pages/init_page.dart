import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hackstorage/feature/users/presentation/pages/login_page.dart';
import 'package:hackstorage/feature/users/presentation/pages/register_page.dart';
import 'package:hackstorage/feature/users/presentation/widgets/elevate_bottom_customed.dart';
import 'package:hackstorage/settings/settings_provider.dart';
import 'package:hackstorage/settings/styles/colors_data.dart';
import 'package:hackstorage/settings/widgets/appbar_wg.dart';
import 'package:provider/provider.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  void _checkConnectivity() async {
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    settingsProvider.connectivityResultSet(
      await (Connectivity().checkConnectivity()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColrsData.black,
      appBar: WGAppBar().customAppBar(context, false),
      body: Center(
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
              height: 300,
            ),
            CustomElevateButtom(
              label: 'Iniciar Sesion',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              heigth: 50,
              width: 300,
            ),
            const SizedBox(
              height: 50,
            ),
            CustomElevateButtom(
              label: 'Registrate',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  ),
                );
              },
              heigth: 50,
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}
