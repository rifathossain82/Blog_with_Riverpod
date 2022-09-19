import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

class Network{
  static const baseUrl = 'https://apiv1.techofic.com/app/techofice/';

  static getRequest(String endPoint)async{
    if(await isNetworkAvailable()){
      Response response;

      var headers = {
        'Content-type' : 'application/json',
        'Accept' : 'application/json'
      };

      response = await get(Uri.parse(baseUrl + endPoint), headers: headers);
      return response;
    }
  }

}