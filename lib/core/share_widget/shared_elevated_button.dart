import 'package:flutter/material.dart';

class SharedElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData? icon;
  final String? iconString;
  final String title;
  final Color? backgroundColor;

  const SharedElevatedButton(this.title,
      {this.icon,
      this.onPressed,
      Key? key,
      this.iconString,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          onPrimary: backgroundColor ?? Theme.of(context).primaryColor),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16)),
            if (iconString != null || icon != null) const SizedBox(width: 12),
            if (iconString != null)
              ImageIcon(
                AssetImage(iconString!),
                size: 20,
              ),
            if (icon != null) Icon(icon, size: 20)
          ],
        ),
      ),
    );
  }
}

class SharedElevatedButtonForSocial extends StatelessWidget {
  final void Function()? onPressed;
  final IconData? icon;

  final String title;

  const SharedElevatedButtonForSocial(this.title,
      {this.icon, this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.grey.shade300,
              )),
          onSurface: Colors.white.withOpacity(0.38),
          surfaceTintColor: Colors.white.withOpacity(0.12)),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.facebook,
              size: 20,
              color: Colors.blue,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
