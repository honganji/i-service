import 'package:flutter/material.dart';

// home name tile
class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "i-service",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Text(
            "Information Management App",
            style: Theme.of(context).textTheme.displaySmall,
          )
        ],
      ),
    );
  }
}
