import 'package:api_tutorials/view/screens/categoriesscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Categorieschips extends StatelessWidget {
  Categorieschips({super.key});
  var chiplist=["best","cars","beautiful","nature","games","cricket","flowers","gameing",];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: chiplist.length,
        itemBuilder: (context, index) =>  Padding(
          padding: const EdgeInsets.all(3),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Categoriesscreen(searchitem: chiplist[index]),));
            },
            child: Chip(
                color: WidgetStatePropertyAll(Colors.black12),
                elevation: 20,
                clipBehavior: Clip.hardEdge,
                shadowColor: Colors.black38,
                shape:BeveledRectangleBorder(borderRadius: BorderRadius.circular(13)),
                // RoundedRectangleBorder(borderRadius:BorderRadius.circular(30)),
                label: Text(chiplist[index])),
          ),
        ),),
    );
  }
}

