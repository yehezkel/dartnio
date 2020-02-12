
import 'client.dart';
import 'request.dart';

class Bucket {
  final Name;
  Bucket(this.Name);
}


List<Bucket> ListBuckets (Client client) {
  return [];
}

bool BucketExists(String name, Client client) {

  //todo: validate request 
  var payload = ApiRequest({
    "method": "HEAD",
    "bucket": name,   
  });

  client.DoRequest(payload);
  return false;
}