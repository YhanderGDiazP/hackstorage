import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pruebas_provider.dart';

class PruebasView extends StatelessWidget {
  const PruebasView({super.key});

  @override
  Widget build(BuildContext context) {
    final pruebasProvider = Provider.of<PruebasProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  
                },
                child: const Text('Prueba?'),
              ),
              const SizedBox(
                height: 50,
              ),
              pruebasProvider.seLogro == false
                  ? Container(
                      height: 100,
                      width: 100,
                      color: Colors.red,
                      child: const Center(
                        child: Text(
                          'No se logro',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Container(
                      height: 100,
                      width: 100,
                      color: Colors.green,
                      child: const Center(
                        child: Text(
                          'Si se logro',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
