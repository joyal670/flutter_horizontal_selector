import 'package:flutter/material.dart';

/// A horizontal picker widget that allows users to select a value from a list.
///
/// The picker displays a list of values in a horizontal layout, with the selected
/// value highlighted. The user can scroll through the list to select a different value.
///
/// The widget provides a range of customization options, including the ability to
/// specify the text style, decoration, and padding for the selected and unselected
/// items.
class HorizontalPicker extends StatefulWidget {
  /// The list of values to be displayed in the picker.
  final List<num> values;

  /// The text style to be used for the selected item.
  final TextStyle? selectedTextStyle;

  /// The text style to be used for the unselected items.
  final TextStyle? unselectedTextStyle;

  /// A callback function that is called when the user selects a new value.
  final ValueChanged<num> onValueSelected;

  /// The height of the picker.
  final double pickerHeight;

  /// The extent of each item in the picker.
  final double itemExtent;

  /// The diameter ratio of the picker.
  final double diameterRatio;

  /// The perspective of the picker.
  final double perspective;

  /// The initial index of the selected item.
  final int? initialSelectedIndex;

  /// A callback function that is called to provide haptic feedback when the user
  /// selects a new value.
  final VoidCallback? hapticFeedback;

  /// The decoration to be used for the selected item.
  final BoxDecoration? selectedItemDecoration;

  /// The decoration to be used for the unselected items.
  final BoxDecoration? unselectedItemDecoration;

  /// The padding to be used for the selected item.
  final EdgeInsets? selectedItemPadding;

  /// The padding to be used for the unselected items.
  final EdgeInsets? unSelectedItemPadding;

  /// The duration of the scroll animation.
  final Duration? scrollDuration;

  /// Creates a new instance of the HorizontalPicker widget.
  const HorizontalPicker({
    super.key,
    required this.values,
    required this.onValueSelected,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.pickerHeight = 90,
    this.itemExtent = 100,
    this.diameterRatio = 2.5,
    this.perspective = 0.0001,
    this.initialSelectedIndex,
    this.hapticFeedback,
    this.selectedItemDecoration,
    this.unselectedItemDecoration,
    this.selectedItemPadding,
    this.unSelectedItemPadding,
    this.scrollDuration,
  });

  @override
  State<HorizontalPicker> createState() => _HorizontalPickerState();
}

/// The state class for the HorizontalPicker widget.
///
/// This class manages the state of the HorizontalPicker widget, including the
/// scroll controller, selected index notifier, and text style.
class _HorizontalPickerState extends State<HorizontalPicker> {
  /// The scroll controller for the ListWheelScrollView.
  late FixedExtentScrollController _scrollController;

  /// The notifier for the currently selected index.
  late ValueNotifier<int> _selectedIndexNotifier;

  @override
  /// Initializes the state of the HorizontalPicker widget.
  ///
  /// This method is called when the widget is inserted into the tree.
  void initState() {
    super.initState();

    // Initialize the selected index notifier with the initial selected index.
    _selectedIndexNotifier = ValueNotifier(widget.initialSelectedIndex ?? 0);

    // Initialize the scroll controller with the initial selected index.
    _scrollController = FixedExtentScrollController(
      initialItem: _selectedIndexNotifier.value,
    );

    // Add a post-frame callback to notify the parent widget of the initial selected value.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onValueSelected(widget.values[_selectedIndexNotifier.value]);
    });
  }

  @override
  /// Disposes of the resources used by the HorizontalPicker widget.
  ///
  /// This method is called when the widget is removed from the tree.
  void dispose() {
    // Dispose of the scroll controller.
    _scrollController.dispose();

    // Dispose of the selected index notifier.
    _selectedIndexNotifier.dispose();

    super.dispose();
  }

  /// Returns the text style for the given index based on whether it is selected.
  ///
  /// If the index is selected, returns the selected text style. Otherwise, returns
  /// the unselected text style.
  TextStyle _getTextStyle(bool isSelected) {
    return isSelected
        ? widget.selectedTextStyle ??
            const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)
        : widget.unselectedTextStyle ??
            const TextStyle(fontSize: 16, fontWeight: FontWeight.normal);
  }

  /// Builds the HorizontalPicker widget.
  ///
  /// This method is called when the widget is inserted into the tree.
  @override
  Widget build(BuildContext context) {
    // Center the picker horizontally and vertically
    return Center(
      child: SizedBox(
        // Set the height of the picker
        height: widget.pickerHeight,
        child: RotatedBox(
          // Rotate the picker 90 degrees to make it horizontal
          quarterTurns: 3,
          child: ListWheelScrollView.useDelegate(
            // Set the scroll controller for the picker
            controller: _scrollController,
            // Set the physics for the scroll view
            physics: const FixedExtentScrollPhysics(),
            // Set the extent of each item in the list
            itemExtent: widget.itemExtent,
            // Set the diameter ratio for the scroll view
            diameterRatio: widget.diameterRatio,
            // Set the perspective for the scroll view
            perspective: widget.perspective,
            // Handle changes to the selected item
            onSelectedItemChanged: (index) {
              // Check if the new index is the same as the current index
              if (_selectedIndexNotifier.value == index) return;
              // Update the selected index notifier
              _selectedIndexNotifier.value = index;

              // Animate the scroll controller to the new index
              if (_scrollController.hasClients) {
                _scrollController.animateToItem(
                  index,
                  // Set the duration and curve for the animation
                  duration:
                      widget.scrollDuration ??
                      const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }

              // Call the haptic feedback callback if provided
              widget.hapticFeedback?.call();

              // Call the onValueSelected callback with the new selected value
              widget.onValueSelected(widget.values[index]);
            },
            // Build the child delegate for the list wheel scroll view
            childDelegate: ListWheelChildBuilderDelegate(
              // Build each item in the list
              builder: (context, index) {
                // Check if the index is out of range
                if (index < 0 || index >= widget.values.length) return null;

                // Rotate the item 90 degrees to make it vertical
                return RotatedBox(
                  quarterTurns: 1,
                  child: Center(
                    child: ValueListenableBuilder(
                      // Listen to the selected index notifier
                      valueListenable: _selectedIndexNotifier,
                      // Build the item based on whether it's selected
                      builder: (context, selectedIndex, child) {
                        // Check if the item is selected
                        final isSelected = index == selectedIndex;
                        return Container(
                          // Set the decoration and padding based on whether the item is selected
                          decoration:
                              isSelected
                                  ? widget.selectedItemDecoration
                                  : widget.unselectedItemDecoration,
                          padding:
                              isSelected
                                  ? widget.selectedItemPadding
                                  : widget.unSelectedItemPadding,
                          child: Text(
                            // Display the value of the item
                            widget.values[index].toString(),
                            // Get the text style based on whether the item is selected
                            style: _getTextStyle(isSelected),
                            // Set the max lines and overflow for the text
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              // Set the child count for the list wheel scroll view
              childCount: widget.values.length,
            ),
          ),
        ),
      ),
    );
  }
}
