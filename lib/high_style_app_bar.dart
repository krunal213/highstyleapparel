import 'package:flutter/material.dart';

class HighStyleAppBar extends StatelessWidget implements PreferredSizeWidget {

  const HighStyleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 33),
      child: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Material(
            elevation: 0.8, // Adjust elevation for shadow effect
            shape: const CircleBorder(),
            child: IconButton(
              iconSize: 16,
              icon:const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context); // context is available here
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
