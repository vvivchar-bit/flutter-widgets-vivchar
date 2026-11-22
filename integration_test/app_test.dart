import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_widgets_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('TechStore: основний сценарій користувача', (tester) async {
    // 1. Запуск застосунку.
    await tester.pumpWidget(const TechStoreApp());
    await tester.pumpAndSettle();

    expect(find.text('Бібліотека компонентів'), findsOneWidget);

    // 2. Перевірка лічильника.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget);

    // 3. Перехід до каталогу.
    await tester.tap(find.text('Каталог'));
    await tester.pumpAndSettle();

    expect(find.text('Каталог товарів'), findsOneWidget);

    // 4. Додавання товару до обраного.
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite), findsOneWidget);

    // 5. Додавання товару до кошика.
    final cartButton = find.text('До кошика').first;

    await tester.ensureVisible(cartButton);
    await tester.pumpAndSettle();

    await tester.tap(cartButton);
    await tester.pumpAndSettle();

    // 6. Повертаємо каталог до початку,
    // щоб лічильник кошика був видимий.
    await tester.drag(find.byType(ListView), const Offset(0, 800));
    await tester.pumpAndSettle();

    expect(find.text('Товарів у кошику: 1'), findsOneWidget);

    // 7. Перехід до профілю.
    await tester.tap(find.text('Профіль'));
    await tester.pumpAndSettle();

    expect(find.text('Особистий кабінет'), findsOneWidget);

    // 8. Редагування профілю.
    await tester.tap(find.text('Редагувати'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextFormField).first,
      'Тестовий користувач',
    );

    await tester.tap(find.text('Зберегти'));
    await tester.pumpAndSettle();

    expect(find.text('Тестовий користувач'), findsOneWidget);

    // 9. Перемикання теми.
    await tester.tap(find.byTooltip('Змінити тему'));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.light_mode), findsOneWidget);
  });
}
