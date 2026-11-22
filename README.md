

\# TechStore — Flutter Widgets App



\*\*Студент:\*\* Вівчар Вадим  

\*\*Група:\*\* ALK43  

\*\*Дисципліна:\*\* Програмування для мобільних платформ  

\*\*Практична робота №5:\*\* Flutter Widgets та керування станом



\## Опис



TechStore — навчальний застосунок магазину електроніки, розроблений на Flutter.



Застосунок демонструє використання StatelessWidget, StatefulWidget, анімацій, власних UI-компонентів та керування станом через ChangeNotifier.



\## Функціональність



\- Головна сторінка з демонстрацією кнопок і анімованим лічильником.

\- Каталог смартфонів, ноутбуків і навушників.

\- Додавання товарів до обраного та кошика.

\- Фільтрація обраних товарів.

\- Збільшення фотографій товарів.

\- Особистий кабінет із редагуванням профілю.

\- Компактний режим профілю.

\- Світла й темна теми.

\- Адаптивне відображення екранів.



\## Власні віджети



\- `CustomButton` — кнопка з різними стилями та індикатором завантаження.

\- `ProfileWidget` — адаптивний компонент профілю.

\- `AnimatedCounter` — лічильник з анімаціями та індикатором прогресу.

\- `ProductCard` — картка товару з обраним, анімацією, масштабуванням фотографії та Shimmer.



\## Структура проєкту



```text

lib/

&#x20; main.dart

&#x20; models/

&#x20;   user.dart

&#x20;   product.dart

&#x20; screens/

&#x20;   home\_screen.dart

&#x20;   products\_screen.dart

&#x20;   profile\_screen.dart

&#x20; widgets/

&#x20;   custom\_button.dart

&#x20;   profile\_widget.dart

&#x20;   animated\_counter.dart

&#x20;   product\_card.dart

&#x20; utils/

&#x20;   app\_state.dart

&#x20;   constants.dart

&#x20;   themes.dart



assets/

&#x20; images/



test/

&#x20; app\_state\_test.dart

&#x20; custom\_widgets\_test.dart



integration\_test/

&#x20; app\_test.dart



docs/

reports/

```



\## Керування станом



Для керування станом використано клас `AppState`, який успадковує `ChangeNotifier`.



Він відповідає за:

\- Дані поточного користувача.

\- Список обраних товарів.

\- Кількість товарів у кошику.

\- Повідомлення інтерфейсу про зміну стану через `notifyListeners()`.



\## Запуск



Необхідно встановити Flutter SDK та налаштувати середовище розробки.



У кореневій папці проєкту виконайте:



```bash

flutter pub get

flutter run -d chrome

```



Для запуску на підключеному Android-пристрої:



```bash

flutter run

```



\## Тестування



Перевірено логіку `AppState`, роботу власних віджетів та інтеграційний сценарій користувача.



Результати:

\- 8 модульних тестів — успішно.

\- 5 тестів віджетів — успішно.

\- 1 інтеграційний тест на Android — успішно.

\- `flutter analyze` — без помилок.

\- Покриття рядків коду — \*\*84,9% (202 із 238)\*\*.



Команди:



```bash

flutter analyze

flutter test

flutter test --coverage

flutter test integration\_test/app\_test.dart -d emulator-5554

```



Звіт про покриття: `reports/lcov.info`.



\## Збірка Android APK



```bash

flutter build apk --release

```



Результат збірки:



```text

build/app/outputs/flutter-apk/app-release.apk

```



\## Скриншоти



\### Головна сторінка



!\[Головна сторінка](docs/home.png)



\### Каталог товарів



!\[Каталог](docs/catalog.png)



\### Особистий кабінет



!\[Профіль](docs/profile.png)



\### Темна тема



!\[Темна тема](docs/dark\_theme.png)



\### Обране та перегляд фотографії



!\[Обране та збільшення фотографії](docs/favorites\_and\_zoom.png)







