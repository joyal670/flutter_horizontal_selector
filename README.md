<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

A customizable horizontal picker for Flutter, ideal for selecting values like weight, age, or quantity — with smooth scroll, haptic feedback, and ValueNotifier support.

## Features

- 🔁 **Horizontal wheel-style picker** — Rotated ListWheelScrollView for smooth horizontal scrolling.
- ⚡ **Efficient updates with ValueNotifier** — Minimizes rebuilds for better performance.
- 🎯 **Custom decorations** — Style selected and unselected items with different text styles, paddings, and decorations.
- 📱 **Haptic feedback** — Optional haptic response when values change.
- 🔢 **Supports numeric value selection** — Perfect for picking weight, age, quantity, and other numeric values.
- 🎨 **Highly customizable** — Control picker height, item size, scroll animation, perspective, and more.
- 🧩 **Easy to integrate** — Drop-in widget for your next Flutter form or input screen.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

Use `HorizontalPicker` to let users select a value from a horizontal scrollable list, ideal for inputs like weight or age.

Customize text styles, decorations, and scroll behavior. Simply pass a list of numbers and get the selected value via a callback. 

Perfect for fitness, health, or any numeric input UI.

check the /example folder in the repository.

## 📸 Screenshot

![Horizontal Picker Screenshot](https://github.com/joyal670/flutter_horizontal_selector/blob/master/screenshot.png?raw=true)


```dart
class WeightSelector extends StatelessWidget {
  const WeightSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalPicker(
      values: List<num>.generate(200, (index) => index + 1), // 1 to 200
      onValueSelected: (value) {
        print("Selected weight: $value kg");
      },
      selectedTextStyle: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      unselectedTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black54,
      ),
      pickerHeight: 100,
      itemExtent: 80,
      diameterRatio: 2.5,
      perspective: 0.003,
      initialSelectedIndex: 69, // defaults to 70
      hapticFeedback: () => HapticFeedback.mediumImpact(),
      selectedItemDecoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      unselectedItemDecoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      selectedItemPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      unSelectedItemPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      scrollDuration: const Duration(milliseconds: 300),
    );
  }
}
```

## Contributing 🤝

Contributions are welcome! If you'd like to improve this package, feel free to reach out or submit a pull request.

## Reporting Issues 🐛

If you find a bug or have a feature request, please open an issue on the GitHub Issues page. When reporting an issue, include:
- A clear description of the problem
- Steps to reproduce (if applicable)
- Expected vs. actual behavior
- Logs or screenshots (if relevant)  
