
import 'client.dart';
import 'request.dart';
import "package:http/http.dart" as http;


List<Bucket> ListBuckets (Client client) {
  return [];
}

Future<bool> BucketExists(String name, Client client) {

  //todo: validate request 
  var payload = ApiRequest({
    "method": "HEAD",
    "bucket": name,   
  });

  return client.DoRequest(payload).then((resp) {
    return (resp.statusCode == 200);
  });
}


Future<String> BucketList(Client client) {

  //todo: validate request 
  var payload = ApiRequest({
    "method": "GET",   
  });

  return client.DoRequest(payload).then((resp) {
    return http.Response.fromStream(resp);
  }).then((resp) {
    return resp.body;
  });
}