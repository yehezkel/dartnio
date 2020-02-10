


import 'request.dart';
import 'response.dart';
import 'urlbuilder.dart';
import 'urlbuilder/pathurlbuilder.dart';
import 'credentials.dart';
import 'signer.dart';
import 'package:http/http.dart' as http;

class Client {
  final String _endpoint;
  final String _accessKey;
  final String _secretKey;

  UrlBuilder _urlBuilder;
  CredentialProvider _credentailSource;
  Signer signer;

  Client(this._endpoint, this._accessKey, this._secretKey) {
    //url builder temporarly fixing path based
    this._urlBuilder = PathUrlBuilder(this._endpoint);

  }


  ApiResponse DoRequest(ApiRequest request) {

    var initialUri = this._urlBuilder.BuildUrl(
      request.Lookup("bucket"), 
      request.Lookup("object"),
      request.Lookup("location") //check for global location
    );

    var initialHttp = http.Request(request.Lookup("method"),Uri.parse(initialUri));
    //move from apirequest to initialhttp request

    //sign request
    var fullRequest = this.signer.Sign(initialHttp);

    var client = http.Client();
    client.send(fullRequest);
    //wrapp above response on this
    return ApiResponse();
  }
}