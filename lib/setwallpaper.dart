import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Setwallpaper extends StatefulWidget {
  Setwallpaper({super.key, required this.url, required this.tag, required this.photo});
  final Map photo;
  final String url;
  final String tag;

  @override
  State<Setwallpaper> createState() => SetwallpaperState();
}

class SetwallpaperState extends State<Setwallpaper> {
  bool isfavourite = true;

  @override
  void initState() {
    super.initState();
    setIsFavourite();
  }

  Future<void> setIsFavourite() async {
    bool favourite = await checkIsFavourite();
    setState(() {
      isfavourite = favourite;
    });
  }

  Future<bool> checkIsFavourite() async {
    var box = Hive.box("favourite1");
    List<dynamic> check = box.get("list",defaultValue:  List<dynamic>.empty(growable: true));
    for (var item in check) {
      if (item["id"] == widget.photo["id"]) {
        return true;
      }
    }
    return false;
  }

  void toggleFavourite() async {
    if (await checkIsFavourite()) {
      removeFromFavourite();
    } else {
      addToFavourite();
    }

    setState(() {
      isfavourite = !isfavourite;
    });
  }

  void addToFavourite() {
    var box = Hive.box("favourite1");
    List<dynamic> list = box.get("list", defaultValue: List<dynamic>.empty(growable: true));
    if (!list.any((element) => element["id"] == widget.photo["id"])) {
      list.add(widget.photo);
      box.put("list", list);
    }
  }

  void removeFromFavourite() {
    var box = Hive.box("favourite1");
    List<dynamic> list = box.get("list", defaultValue: List<dynamic>.empty(growable: true));
    list.removeWhere((element) => element["id"] == widget.photo["id"]);
    box.put("list", list);
  }

  Future<void> setWallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.url);
    await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.93,
                  child: CachedNetworkImage(imageUrl: widget.url, fit: BoxFit.cover),
                ),
                Positioned(
                  right: 15,
                  top: 30,
                  child: IconButton(
                    onPressed: toggleFavourite,
                    icon: isfavourite
                        ? const FaIcon(FontAwesomeIcons.heartCircleCheck, size: 40, color: Colors.red)
                        : const FaIcon(FontAwesomeIcons.heart, size: 40),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: setWallpaper,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: double.infinity,
              color: Colors.black,
              child: const Center(
                child: Text(
                  "Set Wallpaper",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
