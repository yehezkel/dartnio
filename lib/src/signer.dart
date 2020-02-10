
import 'package:http/http.dart' as http;
import 'credentials.dart';

abstract class Signer {

  http.Request Sign(http.Request target);

}


class AwsV4HeaderSigner implements Signer {
  
  final CredentialProvider _provider;
  
  AwsV4HeaderSigner(this._provider);

  http.Request Sign(http.Request target) {
    var credentials = this._provider.Credentials();
    
    if (credentials.SessionToken != "") {
      target.headers["X-Amz-Security-Token"] = credentials.SessionToken;
    }

    return target;
  }
}