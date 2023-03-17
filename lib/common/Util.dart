import 'API.dart';

class  Util{
  static String getImageUrl(String url){
    if(url.isNotEmpty&&url!=""){
      if(url[0]=='/'){
        return API.url+url;
      }
      return url;
    }
    return "https://via.placeholder.com/800x1000";

  }
}