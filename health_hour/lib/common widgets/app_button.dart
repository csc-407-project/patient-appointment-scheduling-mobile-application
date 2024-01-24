
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key, required this.onPressed, required this.child, this.backgroundColor, this.foregroundColor
  });

final VoidCallback onPressed;
final Widget child;
final Color? backgroundColor;
final Color? foregroundColor;
  @override
  Widget build(BuildContext context) {
    return     ElevatedButton(onPressed: onPressed, 
    style: ElevatedButton.styleFrom(
      backgroundColor:backgroundColor ?? const Color(0xFF2F195A),
      // ProjectColors.primaryColor,
      foregroundColor: foregroundColor?? Colors.white,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25)
    
    
      )
    ),
    child: child);
  }
}