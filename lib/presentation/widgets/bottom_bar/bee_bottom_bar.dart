import 'package:collection/collection.dart' show ListEquality;
import 'package:flutter/material.dart';
import 'package:movie_app_clean_architecture/config/theme/theme.dart';

import 'bottom_bar_item.dart';
import 'bubble_selection_painter.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({
    super.key,
    required this.items,
    this.initialIndex = 0,
    this.onItemSelected,
  });

  final List<BottomBarItem> items;
  final int initialIndex;
  final ValueChanged<int>? onItemSelected;

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  final List<int> specialIndex = [];

  int currentIndex = 0;

  @override
  void initState() {
    findSpecialIndex();

    currentIndex = widget.initialIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!const ListEquality().equals(widget.items, oldWidget.items)) {
      findSpecialIndex();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.only(bottom: 20),
      color: AppColors.onSurfaceColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.items.map((item) {
          final index = widget.items.indexOf(item);

          return _BottomBarItem(
            isSelected: index == currentIndex,
            item: item,
            isSpecial: specialIndex.contains(index),
            onTap: () {
              widget.onItemSelected?.call(index);

              if (index == currentIndex) return;
              currentIndex = index;

              setState(() {});
            },
          );
        }).toList(),
      ),
    );
  }

  void findSpecialIndex() {
    specialIndex.clear();
    final middle = (widget.items.length / 2).floor();
    specialIndex.add(middle);
    if (!widget.items.length.isOdd) {
      specialIndex.add(middle - 1);
    }
  }

  double get widthItem {
    final size = MediaQuery.of(context).size;
    return size.width * (1 - widget.items.length * 0.1) / widget.items.length;
  }
}

class _BottomBarItem extends StatefulWidget {
  const _BottomBarItem({
    super.key,
    required this.isSelected,
    required this.item,
    this.isSpecial = false,
    required this.onTap,
  });

  final bool isSelected;
  final bool isSpecial;
  final VoidCallback onTap;
  final BottomBarItem item;

  @override
  State<_BottomBarItem> createState() => _BottomBarItemState();
}

class _BottomBarItemState extends State<_BottomBarItem> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController scaleController;

  double bubbleRadius = 0;
  double iconScale = 1;
  bool secondTap = false;

  static const double maxSplashRadius = 28;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        secondTap = false;
      }
    });

    final bubbleCurve = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );

    bubbleCurve.addListener(() {
      setState(() {
        bubbleRadius = maxSplashRadius * bubbleCurve.value;
        if (bubbleRadius == maxSplashRadius) {
          bubbleRadius = 0;
        }

        if (bubbleCurve.value < 0.5) {
          iconScale = 1 + bubbleCurve.value;
        } else {
          iconScale = 2 - bubbleCurve.value;
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(
        bubbleRadius: widget.isSelected && !secondTap ? bubbleRadius : 0,
        bubbleColor: AppColors.primaryColor,
        maxBubbleRadius: maxSplashRadius,
      ),
      child: Transform.scale(
        scale: widget.isSelected ? iconScale : 1,
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            widget.onTap();

            if (widget.isSelected) {
              secondTap = true;
              controller.forward(from: 0.0);
            }
          },
          child: Container(
            width: 60,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: widget.isSpecial ? const BorderRadius.all(Radius.circular(15)) : null,
              color: widget.isSpecial ? AppColors.onPrimaryColor : Colors.transparent,
            ),
            child: Center(
              child: Icon(
                widget.item.icon,
                color: iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant _BottomBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (controller.isAnimating) {
        controller.stop();
      }
      controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Color get iconColor => widget.isSelected ? AppColors.primaryColor : Colors.grey;
}
