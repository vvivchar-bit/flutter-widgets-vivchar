
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_widgets_app/models/product.dart';
import 'package:mobile_widgets_app/models/user.dart';
import 'package:mobile_widgets_app/widgets/animated_counter.dart';
import 'package:mobile_widgets_app/widgets/custom_button.dart';
import 'package:mobile_widgets_app/widgets/product_card.dart';
import 'package:mobile_widgets_app/widgets/profile_widget.dart';

void main() {
  testWidgets('CustomButton викликає дію', (tester) async {
    var pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            text: 'Натиснути',
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Натиснути'));
    expect(pressed, isTrue);
  });

  testWidgets('CustomButton показує завантаження', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomButton(
            text: 'Завантаження',
            isLoading: true,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('ProfileWidget відображає користувача', (tester) async {
    const user = User(
      id: '1',
      name: 'Вівчар Вадим',
      email: 'vadim@example.com',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProfileWidget(user: user),
        ),
      ),
    );

    expect(find.text('Вівчар Вадим'), findsOneWidget);
    expect(find.text('vadim@example.com'), findsOneWidget);
  });

  testWidgets('AnimatedCounter збільшує значення', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AnimatedCounter(maxValue: 10),
        ),
      ),
    );

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('ProductCard додає товар до кошика', (tester) async {
    var cartCount = 0;

    const product = Product(
      id: '1',
      name: 'Ноутбук',
      description: 'Ноутбук для навчання',
      price: 32999,
      imageAsset: 'assets/images/laptop.jpg',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductCard(
            product: product,
            onAddToCart: () => cartCount++,
          ),
        ),
      ),
    );

    await tester.tap(find.text('До кошика'));
    await tester.pump();

    expect(cartCount, 1);
  });
}
