import 'dart:convert';
import 'package:api_tutorials/setwallpaper.dart';
import'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart'as http;

class Wallpaper extends StatefulWidget {
  const Wallpaper({super.key, required this.title});

  final String title;

  @override
  State<Wallpaper> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Wallpaper> {
  List images=[];
  int page=1;
  @override
  void initState() {
    super.initState();
    fetch("https://api.pexels.com/v1/curated?per_page=80");
  }
  loadmore()async{
    page++;
    String url="https://api.pexels.com/v1/curated?per_page=80&page=$page";
    fetch(url);

  }
  fetch(String url)async{
    await http.get(Uri.parse(url),
      headers: {
      "Authorization":"HaynMm2QE9jEjsGioi1ZocWp4J8TQgusFwQTOiTe0Mn47UqP4xiN25Qy"
      }
    ).then((value){
      Map result=jsonDecode(value.body);  //store the images data into map dataform
      setState(() {
        images.addAll(result["photos"]); //separate the photos data into list
      });
      // print(images.length);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(widget.title),
        ),
        body:Column(
          children: [
            const SizedBox(height: 5,),
            Expanded(child: Container(
              color: Colors.black,
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              childAspectRatio: 2/4,
              mainAxisSpacing: 2
            ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Setwallpaper(url: images[index]["src"]["large2x"],
                          tag: index.toString(),photo: images[index],),));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      clipBehavior: Clip.hardEdge,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: images[index]["src"]["tiny"],
                        // placeholder: (context, url) => CircularProgressIndicator(),
                        // errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  );
                },),
            ),),
            InkWell(
              onTap: ()=>loadmore(),
              child: Container(
                height: 60,
                width: double.infinity,
                color: Colors.black,
                child: const Center(child: Text("Load More",style: TextStyle(fontSize: 30,color: Colors.white),)),),
            ),
          ],
        )
    );
  }
}
