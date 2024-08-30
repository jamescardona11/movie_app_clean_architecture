import 'package:flutter/material.dart';

class MoviesHeaderView extends StatelessWidget {
  const MoviesHeaderView({
    super.key,
    required this.title,
    this.listView = true,
  });

  final String title;
  final bool listView;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              const SizedBox(
                width: 32,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
