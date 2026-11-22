
# TechStore

Практична робота №5 з дисципліни «Програмування для мобільних платформ».  
Виконав: Вівчар Вадим, група АЛК43.

TechStore — навчальний застосунок магазину електроніки на Flutter. На головному екрані можна перевірити різні кнопки та анімований лічильник. У каталозі є три товари: їх можна додавати до обраного й кошика, переглядати фотографії та фільтрувати обране. У профілі можна змінити ім’я й електронну пошту та ввімкнути компактний вигляд. Також працює перемикання світлої й темної теми.

Для інтерфейсу створено власні віджети `CustomButton`, `ProfileWidget`, `AnimatedCounter` і `ProductCard`. Стан користувача, обраних товарів і кошика зберігається в `AppState` на основі `ChangeNotifier`.

## Як запустити

Потрібен встановлений Flutter SDK. У папці проєкту виконати:

```bash
flutter pub get
flutter run -d chrome
```

Для збірки APK:

```bash
flutter build apk --release
```

Готовий файл буде у `build/app/outputs/flutter-apk/app-release.apk`.

## Тестування

Перевірено 8 тестів стану, 5 тестів віджетів та 1 інтеграційний сценарій на Android. Усі пройшли успішно. `flutter analyze` не виявив помилок. Покриття рядків коду — 84,9% (202 із 238). Звіт: `reports/lcov.info`.

```bash
flutter analyze
flutter test
flutter test --coverage
flutter test integration_test/app_test.dart -d emulator-5554
```

## Скриншоти

[Головна](docs/home.png) · [Каталог](docs/catalog.png) · [Профіль](docs/profile.png) · [Темна тема](docs/dark_theme.png) · [Обране та перегляд фото](docs/favorites_and_zoom.png)

Під час роботи використовував ChatGPT для підготовки частини коду віджетів, екранів і тестів, пошуку помилок та оформлення README. Запуск і перевірку застосунку проводив у власному середовищі розробки.
## Матеріали практичної роботи

- [Вебдемонстрація TechStore](https://vvivchar-bit.github.io/flutter-widgets-vivchar/)
- [Android APK](https://drive.google.com/file/d/1g49tBu-jfxISXy_Pno34fpyZ83RQV1Px/view?usp=sharing)
- [Дизайн-система Figma](https://www.figma.com/design/4bjJA7w5klykpg18G26d3l/TechStore)
- [Відеодемонстрація YouTube](https://youtube.com/shorts/kgIdG0vmgL4)
- [Архітектура застосунку](docs/architecture.png)
- [Схема керування станом](docs/state_flow.png)
- [Дерево віджетів](docs/widget_tree.png)
- [Контракт Mock API](docs/mock_api.md)
### Використання ШІ

ChatGPT використовувався для консультацій із Flutter, допомоги з кодом і тестуванням. Приклад запиту: «корзина не чистится». Використано запропоновані фрагменти коду. Самостійно виконував налаштування, перевірку, виправлення помилок і публікацію застосунку.







