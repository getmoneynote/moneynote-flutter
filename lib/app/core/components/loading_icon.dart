import 'package:flutter/material.dart';

class LoadingIcon extends StatelessWidget {

  const LoadingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 50,
      child: Center(
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 1.5,
          )),
      ),
    );
  }

}
