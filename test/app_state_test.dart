
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_widgets_app/models/product.dart';
import 'package:mobile_widgets_app/models/user.dart';
import 'package:mobile_widgets_app/utils/app_state.dart';

void main() {
  late AppState appState;

  const product = Product(
    id: '1',
    name: 'Ноутбук',
    description: 'Ноутбук для навчання',
    price: 32999,
    imageAsset: 'assets/images/laptop.jpg',
  );

  setUp(() {
    appState = AppState();
  });

  tearDown(() {
    appState.dispose();
  });

  test('Початковий стан порожній', () {
    expect(appState.cartItemsCount, 0);
    expect(appState.favoriteProducts, isEmpty);
    expect(appState.currentUser, isNull);
  });

  test('Додавання товару до обраного', () {
    appState.toggleFavorite(product);

    expect(appState.isFavorite(product), isTrue);
    expect(appState.favoriteProducts.length, 1);
  });

  test('Видалення товару з обраного', () {
    appState.toggleFavorite(product);
    appState.toggleFavorite(product);

    expect(appState.isFavorite(product), isFalse);
    expect(appState.favoriteProducts, isEmpty);
  });

  test('Додавання товарів до кошика', () {
    appState.addToCart(product);
    appState.addToCart(product);

    expect(appState.cartItemsCount, 2);
  });

  test('Очищення кошика', () {
    appState.addToCart(product);
    appState.clearCart();

    expect(appState.cartItemsCount, 0);
  });

  test('Оновлення користувача', () {
    const user = User(
      id: '1',
      name: 'Вадим',
      email: 'vadim@example.com',
    );

    appState.updateUser(user);

    expect(appState.currentUser?.name, 'Вадим');
    expect(appState.currentUser?.email, 'vadim@example.com');
  });

  test('Порожнє ім’я користувача заборонене', () {
    const user = User(
      id: '1',
      name: '',
      email: 'vadim@example.com',
    );

    expect(
          () => appState.updateUser(user),
      throwsArgumentError,
    );
  });

  test('Від’ємна ціна товару заборонена', () {
    const invalidProduct = Product(
      id: '2',
      name: 'Товар',
      description: 'Тест',
      price: -10,
      imageAsset: '',
    );

    expect(
          () => appState.addToCart(invalidProduct),
      throwsArgumentError,
    );
  });
}
