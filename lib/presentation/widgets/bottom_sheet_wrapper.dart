import 'package:airbnb_map/network/test.dart';
import 'package:flutter/material.dart';

class BottomSheetOptions {
  final String? topLabel;
  final double? specifiedPercentageHeight;

  final Color? backgroundColor;
  final Color? textColor;

  final bool isScrollControlled;
  final Duration? withAnimationDuration;

  BottomSheetOptions({
    required this.topLabel,
    required this.specifiedPercentageHeight,
    this.backgroundColor,
    this.textColor,
    this.isScrollControlled = true,
    this.withAnimationDuration,
  });
}

class BottomSheetWrapper extends StatelessWidget {
  final List<Widget> children;

  final BottomSheetOptions options;

  const BottomSheetWrapper({
    super.key,
    required this.options,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: options.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SizedBox(
          height: (options.specifiedPercentageHeight != null)
              ? (MediaQuery.of(context).size.height * options.specifiedPercentageHeight!)
              : null,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Text(
                        options.topLabel ?? '',
                        style: TextStyle(fontSize: 19, color: options.textColor),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.cancel_outlined,
                        size: 24,
                        color: options.textColor,
                      )),
                ],
              ),
              ...children,
            ]),
          ),
        ),
      ),
    );
  }
}

showModalBottomSheetWithWrapper(
        {required BuildContext context, required BottomSheetOptions options, required List<Widget> children}) =>
    showModalBottomSheet(
      backgroundColor: options.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor.withOpacity(.9),
      context: context,
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: options.withAnimationDuration ?? const Duration(seconds: 0),
        value: 0,
      ),
      isScrollControlled: options.isScrollControlled,
      builder: (_) => BottomSheetWrapper(options: options, children: children),
    );
