import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_explore/provider/favorites_provider.dart';
import 'package:space_explore/provider/mars_rover_provider.dart';
import 'package:space_explore/view/favorites_screen.dart';
import 'package:space_explore/view/home_screen.dart';
import 'package:space_explore/view/mars_screen.dart';

class MyApp extends StatelessWidget {
   const MyApp({super.key, this.favoritesBox});
  final favoritesBox;


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MarsRoverProvider()),
        ChangeNotifierProvider(
          create: (_) => FavoritesProvider(favoritesBox),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MarsScreen(),
    const FavoritesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.photo), label: 'Mars Photos'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }
}
