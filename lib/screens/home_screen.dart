import 'package:material_ui/material_ui.dart';
import '../widgets/custom_button.dart';
import '../widgets/animated_counter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'TechStore',
              style: theme.textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            const Text('Магазин сучасної електроніки'),
            const SizedBox(height: 24),
            Text(
              'Бібліотека компонентів',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                CustomButton(
                  text: 'Primary',
                  onPressed: () => _showMessage('Primary'),
                ),
                CustomButton(
                  text: 'Secondary',
                  style: CustomButtonStyle.secondary,
                  onPressed: () => _showMessage('Secondary'),
                ),
                CustomButton(
                  text: 'Danger',
                  style: CustomButtonStyle.danger,
                  onPressed: () => _showMessage('Danger'),
                ),
                CustomButton(
                  text: 'Outline',
                  style: CustomButtonStyle.outline,
                  onPressed: () => _showMessage('Outline'),
                ),
                CustomButton(
                  text: 'Loading',
                  isLoading: _isLoading,
                  icon: const Icon(Icons.download),
                  onPressed: () => _showMessage('Download'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Режим завантаження'),
              value: _isLoading,
              onChanged: (value) {
                setState(() {
                  _isLoading = value;
                });
              },
            ),
            const SizedBox(height: 24),
            const AnimatedCounter(maxValue: 10),
          ],
        ),
      ),
    );
  }
}