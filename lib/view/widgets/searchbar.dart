import 'package:api_tutorials/view/screens/categoriesscreen.dart';
import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  var controller = TextEditingController();
  Searchbar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black38,width: 2),

      ),
      child: Row(
        children: [
           Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Search Wallpaper",
                  errorBorder:InputBorder.none,
                  focusedBorder:InputBorder.none,
                  focusedErrorBorder:InputBorder.none,
                  disabledBorder:InputBorder.none,
                  enabledBorder:InputBorder.none,
                  border:InputBorder.none,
                ),
                controller: controller,
              ),
            ),
          ),
          IconButton(
              onPressed: (){
                    print(controller.text.toString());
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Categoriesscreen(searchitem: controller.text.toString(),),));
          },
              icon: const Icon(Icons.search))
        ],
      ),
    );
  }
}
