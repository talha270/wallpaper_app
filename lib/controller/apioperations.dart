import 'dart:convert';

import 'package:http/http.dart' as http;

class Apioperations{
    static List photos=[];
    static fetchwallpaper(String url)async{
    await http.get(Uri.parse(url),
        headers:{
          "Authorization":"HaynMm2QE9jEjsGioi1ZocWp4J8TQgusFwQTOiTe0Mn47UqP4xiN25Qy"
        } ).then((value){
          Map result=jsonDecode(value.body);
          photos=result["photos"];
    });
    return photos;
  }

}
