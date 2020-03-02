import 'client.dart';
import 'request.dart';
import "package:http/http.dart" as http;

Future<bool> StatObject(String bucketName, String objectName, Client client) {
  var payload = ApiRequest({
    "method": "HEAD",
    "bucket": bucketName, 
    "object": objectName
  });

  return client.DoRequest(payload).then((resp) {
    //return (resp.statusCode == 200);
    return http.Response.fromStream(resp);
  })
  .then((resp) {
    print(resp.body);
    print(resp.headers);
    return (resp.statusCode == 200);
  }) ; 
}