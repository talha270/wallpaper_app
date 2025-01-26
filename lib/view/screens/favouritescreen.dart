import 'package:api_tutorials/setwallpaper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
class Favouritescreen extends StatefulWidget {
  const Favouritescreen({super.key});

  @override
  State<Favouritescreen> createState() => FavouritescreenState();
}

class FavouritescreenState extends State<Favouritescreen> {
  late List photos;
  late Map randomphoto;
  @override
  void initState() {
    super.initState();
    photos=Hive.box("favourite1").get("list",defaultValue: List<dynamic>.empty(growable: true));
    pickrandom();
  }
  pickrandom(){
    if(photos.isNotEmpty){
      randomphoto = (photos..shuffle()).first;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 20,
        title: RichText(text: const TextSpan(
            children: [
              TextSpan(text: "Wallpaper",style:TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
              TextSpan(text: " Master",style:TextStyle(fontSize: 15,color: Colors.red,fontWeight: FontWeight.bold),),
            ]
        )),
      ),
      body:photos.isEmpty?const Center(child: Text("No any favourite",style: TextStyle(color: Colors.red),)):Container(
        margin: const EdgeInsets.all(7),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height/3.5,
                    width: double.infinity,
                    child: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(imageUrl: randomphoto["src"]["large2x"],fit: BoxFit.cover,
                        color: Colors.black38,
                        colorBlendMode: BlendMode.color,),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    top:20,
                    child: Container(
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Favourites",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                          Text("Images",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.red),),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GridView.builder(
                  physics:
                  const BouncingScrollPhysics(),
                  // AlwaysScrollableScrollPhysics(),
                  // ClampingScrollPhysics(),
                  // FixedExtentScrollPhysics(),
                  // NeverScrollableScrollPhysics(),
                  itemCount:photos.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    childAspectRatio: 2/4,
                    mainAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Setwallpaper(photo:photos[index],url: photos[index]["src"]["large2x"],
                            tag: index.toString()),));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        clipBehavior: Clip.hardEdge,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: photos[index]["src"]["large2x"],
                          // placeholder: (context, url) => CircularProgressIndicator(),
                          // errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    );
                  },),
              ),
            ),
            TextButton(onPressed: (){
              setState(() {
              pickrandom();
              });
            }, child: Text("Refresh"))
          ],
        ),
      ),
    );
  }
}


