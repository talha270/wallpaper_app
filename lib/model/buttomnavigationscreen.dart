import 'package:api_tutorials/view/screens/home.dart';
import 'package:flutter/material.dart';

import '../view/screens/favouritescreen.dart';

class Buttomnavigationscreen extends StatefulWidget {
  const Buttomnavigationscreen({super.key});

  @override
  State<Buttomnavigationscreen> createState() => _ButtomnavigationscreenState();
}

class _ButtomnavigationscreenState extends State<Buttomnavigationscreen> {
  int currentpage=0;
  PageController controller=PageController();
  onchange(int index){
    setState(() {
      currentpage=index;
    });
    controller.jumpToPage(currentpage);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: const [
          HomeScreen(),
          Favouritescreen()
        ],
        onPageChanged:(index)=> onchange(index),

      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.heart_broken),label: "Favourite"),
        ],
        onTap:(index)=> onchange(index),
        currentIndex: currentpage,
        backgroundColor: Colors.red,
        elevation: 30,
       unselectedItemColor: Colors.black45,
        selectedItemColor: Colors.black,
      ),
    );
  }
}
