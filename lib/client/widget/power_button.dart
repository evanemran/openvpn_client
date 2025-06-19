import 'package:flutter/material.dart';
import 'package:openvpn_client/commons/app_colors.dart';

class PowerButton extends StatefulWidget {
  final bool isConnected;
  final bool isLoading;
  final VoidCallback onPressed;

  const PowerButton({
    super.key,
    required this.isConnected,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  State<PowerButton> createState() => _PowerButtonState();
}

class _PowerButtonState extends State<PowerButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: MediaQuery.of(context).size.width*0.4,
        height: MediaQuery.of(context).size.width*0.4,
        decoration: BoxDecoration(
          color: widget.isConnected ? Colors.green : AppColors.primaryColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: widget.isLoading ? CircularProgressIndicator(color: Colors.white54,) : Image.asset(
            'assets/images/power_icon.png',
            width: MediaQuery.of(context).size.width*0.2,
            height: MediaQuery.of(context).size.width*0.2,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
