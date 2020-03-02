//import 'dart:html';
import 'dart:io';

//import "../lib/src/request.dart";
import "../lib/src/client.dart";
//import "../lib/src/buckets.dart" as Bucket;
import "../lib/src/object.dart" as Object;


/*void main() async{

  /*var client = NewClient(
      "https://play.min.io", 
      "Q3AM3UQ867SPQQA43P2F", 
      "zuf+tfteSlswRu7BJ86wekitnifILbZam1KYY3TG"
  );*/

  var client = NewClient(
    "http://172.17.0.2:9000",
    "minioadmin",
    "minioadmin"
  );


  var result = await Bucket.BucketExists("00test", client);
  print(result);
  var result2 = await Bucket.BucketList(client);
  print(result2);

}*/


//put text
/*void main() async{


  var client = NewClient(
    "http://172.17.0.2:9000",
    "minioadmin",
    "minioadmin"
  );

  final fpath = "/home/areyes/dart/dartnio/example/api.dart";
  final body = await File(fpath).readAsString();

  var payload = ApiRequest({
    "method": "PUT",
    "bucket": "00test",
    "object": "api.dart",
    "body": body,
  });

  var response = await client.DoRequest(payload);
  print(response);

}*/


//put binary
/*void main() async{


  var client = NewClient(
    "http://172.17.0.2:9000",
    "minioadmin",
    "minioadmin"
  );

  final fpath = "/home/areyes/Pictures/recaptcha.png";
  final bodyBytes  = await File(fpath).readAsBytes();
  
  var payload = ApiRequest({
    "method": "PUT",
    "bucket": "00test",
    "object": "api.dart",
    "bodyBytes": bodyBytes,
    "contentType": "image/png",
  });

  var response = await client.DoRequest(payload);
  print(response);

}*/

void main() async {
  var client = NewClient(
    "http://172.17.0.2:9000",
    "minioadmin",
    "minioadmin"
  );

  var result = await Object.StatObject("00test", "recaptcha.png",client);
  print(result);
}