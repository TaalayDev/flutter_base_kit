import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

/// Enum representing different types of empty states with corresponding translations and icons
class EmptyStateType {
  /// No data available generically
  static const noData = EmptyStateType(
    iconData: Feather.database,
    titleKeys: {'ru': 'Нет данных', 'ky': 'Маалымат жок', 'zh': '没有数据'},
    messageKeys: {'ru': 'Данные отсутствуют', 'ky': 'Маалымат табылган жок', 'zh': '没有可用数据'},
  );

  /// No notifications
  static const notifications = EmptyStateType(
    iconData: Feather.bell_off,
    titleKeys: {'ru': 'Нет уведомлений', 'ky': 'Билдирүүлөр жок', 'zh': '没有通知'},
    messageKeys: {'ru': 'У вас нет новых уведомлений', 'ky': 'Сизде жаңы билдирүүлөр жок', 'zh': '您没有新通知'},
  );

  /// No coupons
  static const coupons = EmptyStateType(
    iconData: Icons.local_activity_outlined,
    titleKeys: {'ru': 'Нет купонов', 'ky': 'Купондор жок', 'zh': '没有优惠券'},
    messageKeys: {'ru': 'У вас пока нет купонов', 'ky': 'Сизде азырынча купондор жок', 'zh': '您目前没有优惠券'},
  );

  /// No transaction history
  static const history = EmptyStateType(
    iconData: Icons.history,
    titleKeys: {'ru': 'Нет истории', 'ky': 'Тарых жок', 'zh': '没有历史记录'},
    messageKeys: {'ru': 'История операций пуста', 'ky': 'Операциялардын тарыхы бош', 'zh': '交易历史为空'},
  );

  /// No news items
  static const news = EmptyStateType(
    iconData: Icons.newspaper,
    titleKeys: {'ru': 'Нет новостей', 'ky': 'Жаңылыктар жок', 'zh': '没有新闻'},
    messageKeys: {'ru': 'Список новостей пуст', 'ky': 'Жаңылыктар тизмеси бош', 'zh': '新闻列表为空'},
  );

  /// No promotions available
  static const promotions = EmptyStateType(
    iconData: Icons.discount_outlined,
    titleKeys: {'ru': 'Нет акций', 'ky': 'Акциялар жок', 'zh': '没有促销活动'},
    messageKeys: {'ru': 'В данный момент нет акций', 'ky': 'Учурда акциялар жок', 'zh': '目前没有促销活动'},
  );

  /// No gas stations found
  static const gasStations = EmptyStateType(
    iconData: Icons.local_gas_station,
    titleKeys: {'ru': 'Заправки не найдены', 'ky': 'Май куюучу жайлар табылган жок', 'zh': '未找到加油站'},
    messageKeys: {'ru': 'В этом районе нет заправок', 'ky': 'Бул аймакта май куюучу жайлар жок', 'zh': '该地区没有加油站'},
  );

  /// Search returned no results
  static const searchResults = EmptyStateType(
    iconData: Icons.search_off,
    titleKeys: {'ru': 'Ничего не найдено', 'ky': 'Эч нерсе табылган жок', 'zh': '未找到任何内容'},
    messageKeys: {
      'ru': 'Попробуйте изменить параметры поиска',
      'ky': 'Издөө параметрлерин өзгөртүп көрүңүз',
      'zh': '尝试更改搜索参数',
    },
  );

  /// No transactions found
  static const noTransactions = EmptyStateType(
    iconData: Icons.money_off,
    titleKeys: {'ru': 'Транзакции не найдены', 'ky': 'Транзакциялар табылган жок', 'zh': '未找到交易'},
    messageKeys: {'ru': 'У вас пока нет транзакций', 'ky': 'Сизде азырынча транзакциялар жок', 'zh': '您目前没有交易'},
  );

  /// Network or connection error
  static const networkError = EmptyStateType(
    iconData: Icons.wifi_off,
    titleKeys: {'ru': 'Ошибка подключения', 'ky': 'Туташуу катасы', 'zh': '连接错误'},
    messageKeys: {
      'ru': 'Проверьте подключение к интернету',
      'ky': 'Интернет байланышыңызды текшериңиз',
      'zh': '请检查您的互联网连接',
    },
    buttonTextKeys: {'ru': 'Повторить', 'ky': 'Кайталоо', 'zh': '重试'},
  );

  /// Server error
  static const serverError = EmptyStateType(
    iconData: Icons.error_outline,
    titleKeys: {'ru': 'Ошибка сервера', 'ky': 'Сервер катасы', 'zh': '服务器错误'},
    messageKeys: {
      'ru': 'Что-то пошло не так, попробуйте позже',
      'ky': 'Бир нерсе туура эмес болду, кийинчерээк кайталап көрүңүз',
      'zh': '出现问题，请稍后再试',
    },
    buttonTextKeys: {'ru': 'Повторить', 'ky': 'Кайталоо', 'zh': '重试'},
  );

  /// No points or bonuses
  static const noPoints = EmptyStateType(
    iconData: Icons.star_border,
    titleKeys: {'ru': 'Нет бонусов', 'ky': 'Бонустар жок', 'zh': '没有奖励积分'},
    messageKeys: {
      'ru': 'У вас пока нет бонусных баллов',
      'ky': 'Сизде азырынча бонустук упайлар жок',
      'zh': '您目前没有奖励积分',
    },
  );

  /// No favorite items
  static const noFavorites = EmptyStateType(
    iconData: Icons.favorite_border,
    titleKeys: {'ru': 'Нет избранного', 'ky': 'Тандалгандар жок', 'zh': '没有收藏'},
    messageKeys: {
      'ru': 'Вы пока ничего не добавили в избранное',
      'ky': 'Сиз азырынча эч нерсени тандалгандарга кошкон жоксуз',
      'zh': '您尚未将任何内容添加到收藏夹',
    },
  );

  /// No stores found
  static const noStores = EmptyStateType(
    iconData: Feather.shopping_bag,
    titleKeys: {'ru': 'Магазины не найдены', 'ky': 'Дүкөндөр табылган жок', 'zh': '未找到商店'},
    messageKeys: {'ru': 'Пока нет доступных магазинов', 'ky': 'Азырынча колдонуучу дүкөндөр жок', 'zh': '目前没有可用商店'},
  );

  /// No products found
  static const noProducts = EmptyStateType(
    iconData: Feather.shopping_cart,
    titleKeys: {'ru': 'Товары не найдены', 'ky': 'Товардар табылган жок', 'zh': '未找到产品'},
    messageKeys: {'ru': 'Пока нет доступных товаров', 'ky': 'Азырынча колдонуучу товардар жок', 'zh': '目前没有可用产品'},
  );

  const EmptyStateType({
    required this.iconData,
    required this.titleKeys,
    required this.messageKeys,
    this.buttonTextKeys,
  });

  /// Icon to display for this empty state
  final IconData iconData;

  /// Localized title keys for different languages
  final Map<String, String> titleKeys;

  /// Localized message keys for different languages
  final Map<String, String> messageKeys;

  /// Optional localized button text keys
  final Map<String, String>? buttonTextKeys;

  /// Get the localized title for the current locale
  String getTitle(String languageCode) {
    return titleKeys[languageCode] ?? titleKeys['ru'] ?? 'No data';
  }

  /// Get the localized message for the current locale
  String getMessage(String languageCode) {
    return messageKeys[languageCode] ?? messageKeys['ru'] ?? 'No data available';
  }

  /// Get the localized button text for the current locale if available
  String? getButtonText(String languageCode) {
    if (buttonTextKeys == null) return null;
    return buttonTextKeys![languageCode] ?? buttonTextKeys!['ru'];
  }
}

class EmptyStateWidget extends StatelessWidget {
  /// Widget to display when there's no data
  const EmptyStateWidget({
    super.key,
    this.type,
    this.icon,
    this.title,
    this.message,
    this.buttonText,
    this.onButtonPressed,
    this.height,
    this.width,
    this.assetPath,
    this.animate = true,
  });

  /// Predefined empty state type
  final EmptyStateType? type;

  /// Optional custom icon to display
  final IconData? icon;

  /// Optional asset path to display instead of icon
  final String? assetPath;

  /// Title text for the empty state
  final String? title;

  /// Message text for the empty state
  final String? message;

  /// Button text (if button should be displayed)
  final String? buttonText;

  /// Callback for button press
  final VoidCallback? onButtonPressed;

  /// Optional height for the container
  final double? height;

  /// Optional width for the container
  final double? width;

  /// Whether to animate the widget when it appears
  final bool animate;

  @override
  Widget build(BuildContext context) {
    // Get current language code from App context
    final languageCode = Localizations.localeOf(context).languageCode;

    // Determine final values considering both direct props and type-based values
    final finalTitle = title ?? type?.getTitle(languageCode);
    final finalMessage = message ?? type?.getMessage(languageCode);
    final finalButtonText = buttonText ?? type?.getButtonText(languageCode);
    final finalIcon = icon ?? type?.iconData;

    final Widget content = Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(context, icon: finalIcon),
          if (finalTitle != null) ...[
            const SizedBox(height: 16),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                finalTitle,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          if (finalMessage != null) ...[
            const SizedBox(height: 8),
            Text(
              finalMessage,
              style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
              textAlign: TextAlign.center,
            ),
          ],
          if (finalButtonText != null && onButtonPressed != null) ...[
            const SizedBox(height: 24),
            ElevatedButton(onPressed: onButtonPressed, child: Text(finalButtonText)),
          ],
        ],
      ),
    );

    if (!animate) {
      return content;
    }

    return content
        .animate()
        .fadeIn(duration: 300.ms, curve: Curves.easeOut)
        .slideY(begin: 0.1, end: 0, duration: 400.ms, curve: Curves.easeOutCubic);
  }

  Widget _buildIcon(BuildContext context, {IconData? icon}) {
    if (assetPath != null) {
      if (assetPath!.endsWith('.svg')) {
        return SvgPicture.asset(
          assetPath!,
          height: 100,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary.withOpacity(0.3), BlendMode.srcIn),
        );
      }
      return Image.asset(assetPath!, height: 100, color: Theme.of(context).colorScheme.primary.withOpacity(0.3));
    }

    return Icon(icon ?? Icons.search_off, size: 70, color: Theme.of(context).colorScheme.primary.withOpacity(0.3));
  }

  /// Factory constructor for creating an empty state from a predefined type
  factory EmptyStateWidget.fromType({
    Key? key,
    required EmptyStateType type,
    String? title,
    String? message,
    String? buttonText,
    VoidCallback? onButtonPressed,
    double? height,
    double? width,
    bool animate = true,
  }) {
    return EmptyStateWidget(
      key: key,
      type: type,
      title: title,
      message: message,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
      height: height,
      width: width,
      animate: animate,
    );
  }

  /// Factory constructor for creating an empty list state
  factory EmptyStateWidget.list({
    Key? key,
    String? title,
    String? message,
    String? buttonText,
    VoidCallback? onButtonPressed,
    double? height,
  }) {
    return EmptyStateWidget(
      key: key,
      type: EmptyStateType.noData,
      title: title,
      message: message,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
      height: height,
    );
  }

  /// Factory constructor for creating a search empty state
  factory EmptyStateWidget.search({
    Key? key,
    String? title,
    String? message,
    String? buttonText,
    VoidCallback? onButtonPressed,
    double? height,
  }) {
    return EmptyStateWidget(
      key: key,
      type: EmptyStateType.searchResults,
      title: title,
      message: message,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
      height: height,
    );
  }

  /// Factory constructor for creating a network error state
  factory EmptyStateWidget.error({
    Key? key,
    String? title,
    String? message,
    String? buttonText,
    VoidCallback? onButtonPressed,
    double? height,
  }) {
    return EmptyStateWidget(
      key: key,
      type: EmptyStateType.serverError,
      title: title,
      message: message,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
      height: height,
    );
  }

  /// Factory constructor for creating a custom empty state
  factory EmptyStateWidget.custom({
    Key? key,
    required String title,
    required String message,
    required IconData icon,
    String? buttonText,
    VoidCallback? onButtonPressed,
    double? height,
    double? width,
    bool animate = true,
  }) {
    return EmptyStateWidget(
      key: key,
      title: title,
      message: message,
      icon: icon,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
      height: height,
      width: width,
      animate: animate,
    );
  }

  /// Factory constructor for no internet connection state
  factory EmptyStateWidget.noInternet({
    Key? key,
    String? title,
    String? message,
    String? buttonText,
    VoidCallback? onButtonPressed,
    double? height,
  }) {
    return EmptyStateWidget(
      key: key,
      type: EmptyStateType.networkError,
      title: title,
      message: message,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
      height: height,
    );
  }
}
