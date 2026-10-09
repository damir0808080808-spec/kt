
import 'dart:io';

// 1. Меню кафе
List<String> menu = [
  'Бургер',
  'Пицца',
  'Салат',
  'Паста',
  'Кофе',
  'Чай',
];

// Цены блюд
Map<String, int> prices = {
  'Бургер': 450,
  'Пицца': 700,
  'Салат': 300,
  'Паста': 500,
  'Кофе': 150,
  'Чай': 100,
};

// Категории блюд
Set<String> categories = {
  'Основное блюдо',
  'Салат',
  'Напиток',
};

// 2. Приветствие без параметров и без return
void showWelcome() {
  print('================================');
  print('       ДОБРО ПОЖАЛОВАТЬ!');
  print('================================');
  print('       КАФЕ "DART CAFE"');
}

// 3. Вывод меню с помощью for
void showMenu(List<String> menu) {
  print('\n========== МЕНЮ ==========');

  for (int i = 0; i < menu.length; i++) {
    String dish = menu[i];
    print('${i + 1}. $dish — ${prices[dish]} сом');
  }

  // Демонстрация Set: вывод категорий
  print('\nКатегории блюд:');

  for (String category in categories) {
    print('- $category');
  }
}

// 4. Формирование заказа
List<String> createOrder() {
  List<String> order = [];
  String answer = 'yes';

  while (answer == 'yes') {
    stdout.write('\nВведите название блюда или "stop": ');
    String dish = stdin.readLineSync()?.trim() ?? '';

    // Завершение заказа
    if (dish.toLowerCase() == 'stop') {
      break;
    }

    // Проверка существования блюда
    if (menu.contains(dish)) {
      order.add(dish);
      print('$dish добавлен в заказ.');
    } else {
      print('Такого блюда нет в меню.');
      continue;
    }

    stdout.write('Добавить ещё блюдо? yes/no: ');
    answer = (stdin.readLineSync() ?? '').trim().toLowerCase();

    if (answer != 'yes' && answer != 'no') {
      print('Введите yes или no.');
      answer = 'no';
    }
  }

  return order;
}

// 5. Подсчёт общей стоимости
int calculateTotal(List<String> order, Map<String, int> prices) {
  int total = 0;

  for (String dish in order) {
    total += prices[dish]!;
  }

  return total;
}

// 6. Расчёт скидки
int calculateDiscount(int age, bool hasCard) {
  // Булевы переменные
  bool isAdult = age >= 18;
  bool hasLoyaltyCard = hasCard;
  bool isNotCardOwner = !hasCard;

  // && — совершеннолетний И есть карта
  if (isAdult && hasLoyaltyCard) {
    print('Вы совершеннолетний и имеете карту клиента.');
  }

  // || — младше 18 ИЛИ старше 60
  bool specialAge = age < 18 || age > 60;

  if (specialAge) {
    print('Применяется скидка по возрасту.');
  }

  // ! — клиент НЕ имеет карту
  if (isNotCardOwner) {
    print('У вас нет карты постоянного клиента.');
  }

  // Определение скидки
  if (age < 18) {
    return 5;
  } else if (age >= 18 && age <= 60 && hasCard) {
    return 10;
  } else if (age > 60) {
    return 15;
  } else {
    return 0;
  }
}

// 7. Выбор способа оплаты с помощью switch
String choosePayment() {
  print('\n========== ОПЛАТА ==========');
  print('1. Наличные');
  print('2. Карта');
  print('3. QR');

  stdout.write('Выберите способ оплаты: ');
  String choice = stdin.readLineSync()?.trim() ?? '';

  switch (choice) {
    case '1':
      print('Выбран способ оплаты: Наличные');
      return 'Наличные';

    case '2':
      print('Выбран способ оплаты: Карта');
      return 'Карта';

    case '3':
      print('Выбран способ оплаты: QR');
      return 'QR';

    default:
      print('Неизвестный способ оплаты.');
      return 'Не выбран';
  }
}

// 8. Чек: функция с параметрами и без return
void showReceipt(
  List<String> order,
  int total,
  int discount,
  String paymentMethod,
) {
  print('\n================================');
  print('               ЧЕК');
  print('================================');

  // Вывод заказанных блюд
  for (String dish in order) {
    print('$dish — ${prices[dish]} сом');
  }

  // Расчёт суммы скидки и суммы к оплате
  int discountAmount = total * discount ~/ 100;
  int finalTotal = total - discountAmount;

  print('\nОбщая сумма: $total сом');
  print('Скидка: $discount%');
  print('Размер скидки: $discountAmount сом');
  print('К оплате: $finalTotal сом');
  print('Способ оплаты: $paymentMethod');

  print('\nСпасибо за заказ!');
  print('================================');
}

// 9. Бонусы: функция без параметров, но с return
int getBonusPoints() {
  return 10;
}

// 10. Главная функция программы
void main() {
  showWelcome();

  showMenu(menu);

  // Создание заказа
  List<String> order = createOrder();

  // Проверка пустого заказа
  if (order.isEmpty) {
    print('\nВы ничего не заказали.');
    return;
  }

  // Расчёт стоимости
  int total = calculateTotal(order, prices);
  print('\nСтоимость заказа: $total сом');

  // Ввод возраста
  stdout.write('\nВведите ваш возраст: ');
  int age = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

  if (age < 0) {
    print('Некорректный возраст.');
    return;
  }

  // Наличие карты постоянного клиента
  stdout.write('У вас есть карта постоянного клиента? yes/no: ');
  String cardAnswer =
      (stdin.readLineSync() ?? '').trim().toLowerCase();

  bool hasCard = cardAnswer == 'yes';

  // Проверка ответа с помощью if-else
  if (cardAnswer == 'yes') {
    print('Карта клиента подтверждена.');
  } else if (cardAnswer == 'no') {
    print('Карта клиента отсутствует.');
  } else {
    print('Ответ не распознан. Считаем, что карты нет.');
    hasCard = false;
  }

  // Получение скидки
  int discount = calculateDiscount(age, hasCard);

  // Выбор оплаты
  String paymentMethod = choosePayment();

  // Печать итогового чека
  showReceipt(order, total, discount, paymentMethod);

  // Бонусные баллы
  print('\nВы получили ${getBonusPoints()} бонусных баллов!');
}
 