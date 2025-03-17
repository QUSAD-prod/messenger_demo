import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withAlpha(180),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 24.0,
        ),
      ),
    );
  }
}
