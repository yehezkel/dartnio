


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


  ApiResponse DoRequest(ApiRequest request) {

    var initialUri = this._urlBuilder.BuildUrl(
      request.Lookup("bucket"), 
      request.Lookup("object"),
      request.Lookup("location") //check for global location
    );

    var initialHttp = http.Request(request.Lookup("method"),Uri.parse(initialUri));
    //move from apirequest to initialhttp request

    //sign request
    var fullRequest = this._signer.Sign(initialHttp);

    var client = http.Client();
    client.send(fullRequest);
    //wrapp above response on this
    return ApiResponse();
  }
}

Client NewClient(String endpoint, String accessKey, String secretKey) {

  var provider = HardCodedCredentials(accessKey, secretKey);

  return Client(
    PathUrlBuilder(endpoint),
    AwsV4HeaderSigner(provider)
  );
}