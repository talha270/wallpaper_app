import 'package:api_tutorials/controller/apioperations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../setwallpaper.dart';
import '../widgets/categories.dart';
import '../widgets/searchbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isloading=true;
  List photos=[];
  int page=1;
  gettrendingwallpaper()async{
    photos.addAll(await Apioperations.fetchwallpaper("https://api.pexels.com/v1/curated?per_page=80"));
    setState(() {
      isloading=false;
    });
  }
  @override
  void initState() {
    super.initState();
    gettrendingwallpaper();
  }
  loadmore()async{
    page++;
    String url="https://api.pexels.com/v1/curated?per_page=80&page=$page";
    photos.addAll(await Apioperations.fetchwallpaper(url));
    setState(() {

    });
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
      body:isloading? const Center(child: CircularProgressIndicator(),):Container(
        margin: const EdgeInsets.all(7),
        child: Column(
          children: [
            Searchbar(),
             Padding(
              padding: EdgeInsets.all(4.0),
              child: Categorieschips(),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Setwallpaper(url: photos[index]["src"]["large2x"],
                            tag: index.toString(),photo: photos[index],),));
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
            InkWell(
              onTap: ()=>loadmore(),
              child: Container(
                height: 60,
                width: double.infinity,
                color: Colors.black,
                child: const Center(child: Text("Load More",style: TextStyle(fontSize: 30,color: Colors.white),)),),
            ),
          ],
        ),
      ),
    );
  }
}

