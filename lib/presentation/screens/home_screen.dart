import 'package:flutter/material.dart';
import 'package:tarea_login/presentation/screens/apis/movies_api.dart';
import 'package:tarea_login/presentation/screens/information_screen.dart';
import 'package:tarea_login/presentation/screens/json/ensaladas_home.dart';
import 'package:tarea_login/presentation/screens/noticias_dos_screen.dart';
import 'package:tarea_login/presentation/screens/noticias_uno_screen.dart';
import 'package:tarea_login/presentation/screens/xml/home_xml.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Navigation());
  }
}

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blue.shade300,
        backgroundColor: Colors.blue,
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.newspaper_rounded,
              color: Colors.white,
            ),
            label: 'Noticias',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.access_time,
              color: Colors.white,
            ),
            label: 'Ultima Hora',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.movie_filter_outlined,
              color: Colors.white,
            ),
            label: 'Movies',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.info,
              color: Colors.white,
            ),
            label: 'XML',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.food_bank_outlined,
              color: Colors.white,
            ),
            label: 'JSON',
          ),
        ],
      ),
      body: [
        const InformationScreen(),
        const NoticiasUnoScreen(),
        const NoticiasDosScreen(),
        const MoviesApi(),
        const HomeXml(),
        const EnsaladasHome()
      ][currentPageIndex],
    );
  }
}
