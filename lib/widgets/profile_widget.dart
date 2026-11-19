import 'package:material_ui/material_ui.dart';
import '../models/user.dart';

class ProfileWidget extends StatelessWidget {
  final User user;
  final VoidCallback? onEditPressed;
  final bool isCompact;

  const ProfileWidget({
    super.key,
    required this.user,
    this.onEditPressed,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final avatar = CircleAvatar(
      radius: isCompact ? 28 : 55,
      backgroundColor: theme.colorScheme.primaryContainer,
      foregroundImage: user.avatarUrl != null
          ? NetworkImage(user.avatarUrl!)
          : null,
      child: Icon(
        Icons.person,
        size: isCompact ? 30 : 60,
      ),
    );

    final information = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isCompact
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(
          user.name,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(user.email),
        if (onEditPressed != null)
          TextButton.icon(
            onPressed: onEditPressed,
            icon: const Icon(Icons.edit),
            label: const Text('Редагувати'),
          ),
      ],
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (isCompact && constraints.maxWidth >= 300) {
              return Row(
                children: [
                  avatar,
                  const SizedBox(width: 16),
                  Expanded(child: information),
                ],
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                avatar,
                const SizedBox(height: 16),
                information,
              ],
            );
          },
        ),
      ),
    );
  }
}