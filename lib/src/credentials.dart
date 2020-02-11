
class CredentialDetails {
  final String AccessKey;
  final String SecretKey;
  final String SessionToken;

  CredentialDetails(this.AccessKey, this.SecretKey, this.SessionToken);
}

abstract class CredentialProvider {

  CredentialDetails Credentials();
}


class HardCodedCredentials implements CredentialProvider{

   final CredentialDetails _credentials;

   HardCodedCredentials(String accessKey, String secretKey): 
    this._credentials = CredentialDetails(accessKey, secretKey,"");

  CredentialDetails Credentials() {
    return this._credentials;
  }
}