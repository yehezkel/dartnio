import "package:http/http.dart" as http;
import "../lib/src/signer.dart";
import "../lib/src/credentials.dart";

/*void main(){
  final cprovider = HardCodedCredentials("AKIAIOSFODNN7EXAMPLE", "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY");
  final signer = AwsV4HeaderSigner(cprovider);

  final targetUri = Uri.parse("https://examplebucket.s3.amazonaws.com/test.txt");
  final t = DateTime.parse("20130524T000000Z").toUtc();
  var request = http.Request("GET", targetUri);
  request.headers["Host"]  = targetUri.host;
  request.headers["Range"] = " bytes=0-9";

  var result = signer.Sign(request, t:t);
  print(result.headers);


}*/

void main(){
  final cprovider = HardCodedCredentials("AKIAIOSFODNN7EXAMPLE", "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY");
  final signer = AwsV4HeaderSigner(cprovider);

  final targetUri = Uri.parse("https://examplebucket.s3.amazonaws.com/test\$file.text");
  var request = http.Request("PUT", targetUri);
  request.body = "Welcome to Amazon S3.";
  request.headers["Host"]  = targetUri.host;
  request.headers["Date"]  = "Fri, 24 May 2013 00:00:00 GMT";
  request.headers["X-Amz-Date"]  = "20130524T000000Z";
  request.headers["x-amz-storage-class"] = "REDUCED_REDUNDANCY";
  request.headers.remove("Content-Type");

  var result = signer.Sign(request);
  print(result.headers);
}