import 'package:api_tutorials/controller/apioperations.dart';
import 'package:api_tutorials/setwallpaper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Categoriesscreen extends StatefulWidget {
  const Categoriesscreen({super.key,required this.searchitem});
  final String searchitem;
  @override
  State<Categoriesscreen> createState() => _CategoriesscreenState();
}

class _CategoriesscreenState extends State<Categoriesscreen> {
  bool isloading=true;
  int page=1;
  List photos=[];
  @override
  getwallpaper()async{
    photos.addAll(await Apioperations.fetchwallpaper("https://api.pexels.com/v1/search?query=${widget.searchitem}&per_page=80"));
    setState(() {
      isloading=false;
    });
  }
  loadmore()async{
    page++;
    String url="https://api.pexels.com/v1/search?query=${widget.searchitem}&per_page=80&page=$page";
    photos.addAll(await Apioperations.fetchwallpaper(url));
    setState(() {

    });
  }
  @override
  void initState() {
    super.initState();
    getwallpaper();
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
      body:isloading?const Center(child: CircularProgressIndicator(),):Container(
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
                    child: CachedNetworkImage(imageUrl: photos[0]["src"]["large2x"],fit: BoxFit.cover,
                    color: Colors.black38,
                    colorBlendMode: BlendMode.color,),
                  ),
                ),
                Positioned(
                  right: 30,
                  top:20,
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Categoriey",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                        Text(widget.searchitem,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.red),),

                      ],
                    ),
                  ),
                )

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


