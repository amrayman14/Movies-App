import 'package:flutter/material.dart';
import 'package:movies_app/screens/home_screen.dart';
import 'package:movies_app/screens/watch_list_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/watch_list_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen(this.sessionId, this.accountId, {super.key});
  final String sessionId;
  final String accountId;
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends ConsumerState<TabsScreen> {
  int _currentPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  initState() {
    super.initState();
    ref.read(watchListProvider.notifier).setWatchList(widget.accountId, widget.sessionId);

  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const HomeScreen();
    if (_currentPageIndex == 1) {
      activeScreen =
          WatchList(sessionId: widget.sessionId, accountId: widget.accountId);
    }
    return Scaffold(
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Now Playing Movies '),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: 'Watch List'),
        ],
      ),
    );
  }
}
