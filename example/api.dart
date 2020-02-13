import "../lib/src/client.dart";
import "../lib/src/buckets.dart" as Bucket;


void main() async{

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

}