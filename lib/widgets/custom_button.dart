import 'package:material_ui/material_ui.dart';

enum CustomButtonStyle {
  primary,
  secondary,
  danger,
  outline,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final CustomButtonStyle style;
  final Widget? icon;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style = CustomButtonStyle.primary,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading)
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
    else
    ?icon,
        if (icon != null || isLoading)
          const SizedBox(width: 8),
        Text(text),
      ],
    );

    final action = isLoading ? null : onPressed;

    if (style == CustomButtonStyle.outline) {
      return OutlinedButton(
        onPressed: action,
        child: content,
      );
    }

    final background = switch (style) {
      CustomButtonStyle.secondary => colors.secondary,
      CustomButtonStyle.danger => colors.error,
      _ => colors.primary,
    };

    final foreground = switch (style) {
      CustomButtonStyle.secondary => colors.onSecondary,
      CustomButtonStyle.danger => colors.onError,
      _ => colors.onPrimary,
    };

    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: content,
    );
  }
}