import 'package:flutter/material.dart';

import '../themes.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, this.onTap, required this.text}) : super(key: key);
  final void Function()? onTap ;
  final String text ;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(
            text,
            style: primaryStyle.copyWith(
                fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}
