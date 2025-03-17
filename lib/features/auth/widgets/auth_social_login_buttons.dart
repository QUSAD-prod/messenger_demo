import 'package:flutter/material.dart';

class AuthSocialLoginButtons {
  static Widget google({
    required VoidCallback onPressed,
    String text = 'Continue with Google',
    SocialLoginButtonStyle style = SocialLoginButtonStyle.white,
  }) {
    return SocialLoginButton(
      imagePath: 'assets/images/google.png',
      text: text,
      onPressed: onPressed,
      style: style,
    );
  }

  static Widget apple({
    required VoidCallback onPressed,
    String text = 'Continue with Apple ID',
    SocialLoginButtonStyle style = SocialLoginButtonStyle.white,
  }) {
    String imagePath = style == SocialLoginButtonStyle.white ? 'assets/images/apple_white.png' : 'assets/images/apple_black.png';
    return SocialLoginButton(
      imagePath: imagePath,
      text: text,
      onPressed: onPressed,
      style: style,
    );
  }

  static Widget linkedin({
    required VoidCallback onPressed,
    String text = 'Continue with LinkedIn',
    SocialLoginButtonStyle style = SocialLoginButtonStyle.white,
    bool isLoading = false,
  }) {
    return SocialLoginButton(
      imagePath: 'assets/images/linkedin.png',
      text: text,
      onPressed: onPressed,
      style: style,
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onPressed;
  final SocialLoginButtonStyle style;

  Color get _foregroundColor {
    switch (style) {
      case SocialLoginButtonStyle.white:
        return Colors.white;
      case SocialLoginButtonStyle.black:
        return Colors.black;
    }
  }

  const SocialLoginButton({
    super.key,
    this.style = SocialLoginButtonStyle.white,
    required this.imagePath,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
        foregroundColor: WidgetStateProperty.all<Color>(_foregroundColor),
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: _foregroundColor.withAlpha(75),
              width: 0.5,
            ),
          ),
        ),
        overlayColor: WidgetStateProperty.all(Colors.grey.shade100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 25.0,
              width: 25.0,
            ),
            const SizedBox(width: 20.0),
            Text(
              text,
              style: TextStyle(
                color: _foregroundColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum SocialLoginButtonStyle {
  white,
  black,
}
