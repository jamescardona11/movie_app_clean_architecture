import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/bottom_bar/bee_bottom_bar.dart';
import 'package:movie_app_clean_architecture/presentation/widgets/bottom_bar/bottom_bar_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar Text'),
      ),
      body: Container(
        child: const Text('HomePage'),
      ),
      bottomNavigationBar: AppBottomBar(
        items: _itemsBottomBar,
        onItemSelected: (index) {},
      ),
    );
  }

  List<BottomBarItem> get _itemsBottomBar => [
        BottomBarItem(
          label: 'Home',
          icon: FontAwesomeIcons.house,
        ),
        BottomBarItem(
          label: 'Favorites',
          icon: FontAwesomeIcons.solidStar,
        ),
        BottomBarItem(
          label: 'Settings',
          icon: FontAwesomeIcons.film,
        ),
      ];
}
