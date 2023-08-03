import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackstorage/settings/styles/colors_data.dart';

class WGAppBar {
  AppBar customAppBar(BuildContext context, bool desition) {
    return AppBar(
      title: const Text(
        'HACKSTORAGE',
        style: TextStyle(color: ColrsData.white),
      ),
      leading: desition ? IconButton(
        icon: const Icon(
          CupertinoIcons.arrow_left_square_fill,
          color: ColrsData.white,
          size: 30,
        ), // Cambia el icono y el color aquí
        onPressed: () => Navigator.of(context).pop(),
      ) : null,
      centerTitle: true,
      elevation: 0,
      backgroundColor: ColrsData.grey,
    );
  }
}
