import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/constants.dart';
import 'package:flutter/material.dart';

class FavButton extends StatefulWidget {
  const FavButton({Key? key}) : super(key: key);

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  bool _isElevated = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isElevated = !_isElevated;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isElevated
              ? [
                  const BoxShadow(
                    color: Color.fromARGB(255, 32, 32, 32),
                    offset: Offset(-1, 1),
                    blurRadius: 1,
                    spreadRadius: 0.5,
                  ),
                  const BoxShadow(
                    color: Color.fromARGB(255, 38, 38, 38),
                    offset: Offset(1, -1),
                    blurRadius: 1,
                    spreadRadius: 0.3,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: _isElevated
              ? const Icon(
                  Icons.favorite,
                  color: primaryColor,
                )
              : const Icon(
                  Icons.favorite_border,
                  color: Color(0xFF424549),
                ),
        ),
      ),
    );
  }
}
