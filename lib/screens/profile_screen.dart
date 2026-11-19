import 'package:material_ui/material_ui.dart';
import '../models/user.dart';
import '../utils/app_state.dart';
import '../widgets/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  final AppState appState;

  const ProfileScreen({
    super.key,
    required this.appState,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isCompact = false;

  Future<void> _editUser(User user) async {
    final formKey = GlobalKey<FormState>();
    String name = user.name;
    String email = user.email;

    final updated = await showDialog<User>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Редагування профілю'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: user.name,
                decoration: const InputDecoration(
                  labelText: 'Ім’я',
                ),
                onChanged: (value) => name = value,
                validator: (value) =>
                value == null || value.trim().isEmpty
                    ? 'Введіть ім’я'
                    : null,
              ),
              TextFormField(
                initialValue: user.email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Електронна пошта',
                ),
                onChanged: (value) => email = value,
                validator: (value) =>
                value == null || !value.contains('@')
                    ? 'Некоректна адреса'
                    : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Скасувати'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(
                  dialogContext,
                  user.copyWith(
                    name: name.trim(),
                    email: email.trim(),
                  ),
                );
              }
            },
            child: const Text('Зберегти'),
          ),
        ],
      ),
    );

    if (!mounted || updated == null) return;

    widget.appState.updateUser(updated);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.appState,
      builder: (context, child) {
        final user = widget.appState.currentUser;

        if (user == null) {
          return const Center(
            child: Text('Користувач відсутній'),
          );
        }

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Особистий кабінет',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                ProfileWidget(
                  user: user,
                  isCompact: _isCompact,
                  onEditPressed: () => _editUser(user),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Компактний режим'),
                  value: _isCompact,
                  onChanged: (value) {
                    setState(() {
                      _isCompact = value;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}