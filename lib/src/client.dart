


import 'request.dart';
import 'response.dart';
import 'urlbuilder.dart';
import 'urlbuilder/pathurlbuilder.dart';
import 'credentials.dart';
import 'signer.dart';
import 'package:http/http.dart' as http;

class Client {

  UrlBuilder _urlBuilder;
  Signer _signer;

  Client(this._urlBuilder, this._signer);


  Future< http.StreamedResponse> DoRequest(ApiRequest request) {
   
    var initialUri = this._urlBuilder.BuildUrl(
      request.Lookup("bucket"), 
      request.Lookup("object"),
      request.Lookup("location") //check for global location
    );

    var uri = Uri.parse(initialUri);
    var originNoScheme = uri.host;
    if (uri.hasPort) {
      originNoScheme += ":${uri.port}";
    }

    //move from apirequest to initialhttp request
    var initialHttp = http.Request(request.Lookup("method"),uri);

    initialHttp.headers['Host'] = originNoScheme;
    //sign request
    var fullRequest = this._signer.Sign(initialHttp);

    var client = http.Client();
    return client
    .send(fullRequest)
    .whenComplete(() {
      print("completed on client");
      client.close();
    });
  }
}

Client NewClient(String endpoint, String accessKey, String secretKey) {

  var provider = HardCodedCredentials(accessKey, secretKey);

  return Client(
    PathUrlBuilder(endpoint),
    AwsV4HeaderSigner(provider)
  );
}