import 'package:material_ui/material_ui.dart';
import 'models/user.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/products_screen.dart';
import 'utils/app_state.dart';
import 'utils/themes.dart';
import 'utils/constants.dart';

void main() {
  runApp(const TechStoreApp());
}

class TechStoreApp extends StatefulWidget {
  const TechStoreApp({super.key});

  @override
  State<TechStoreApp> createState() => _TechStoreAppState();
}

class _TechStoreAppState extends State<TechStoreApp> {
  final AppState _appState = AppState();

  int _selectedIndex = 0;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();

    _appState.updateUser(
      const User(
        id: '1',
        name: 'Вівчар Вадим',
        email: 'v.vivchar@istu.edu.ua',
      ),
    );
  }

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: _isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TechStore'),
          actions: [
            IconButton(
              tooltip: 'Змінити тему',
              icon: Icon(
                _isDarkMode
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            const HomeScreen(),
            ProductsScreen(appState: _appState),
            ProfileScreen(appState: _appState),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Головна',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_bag),
              label: 'Каталог',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Профіль',
            ),
          ],
        ),
      ),
    );
  }
}