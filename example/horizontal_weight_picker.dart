import 'package:flutter/material.dart';
import 'package:horizontal_slider/src/horizontal_slider.dart';

void main() {
  runApp(const MaterialApp(home: WeightPickerExample()));
}

class WeightPickerExample extends StatefulWidget {
  const WeightPickerExample({super.key});

  @override
  State<WeightPickerExample> createState() => _WeightPickerExampleState();
}

class _WeightPickerExampleState extends State<WeightPickerExample> {
  num _selectedWeight = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weight Selector")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Select your weight", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 16),

          // Use the HorizontalPicker
          HorizontalPicker(
            values: List.generate(100, (index) => index + 1), // 1 to 100 kg
            initialSelectedIndex: 59, // 60 is selected by default
            itemExtent: 80,
            pickerHeight: 100,
            selectedTextStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            unselectedTextStyle: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            selectedItemDecoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue.withOpacity(0.1),
            ),
            unselectedItemDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            selectedItemPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            unSelectedItemPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            scrollDuration: const Duration(milliseconds: 200),
            onValueSelected: (value) {
              setState(() {
                _selectedWeight = value;
              });
            },
            hapticFeedback: () => Feedback.forTap(context),
          ),

          const SizedBox(height: 32),

          Text(
            "Selected Weight: $_selectedWeight kg",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
