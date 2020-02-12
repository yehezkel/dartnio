
class CredentialDetails {
  final String AccessKey;
  final String SecretKey;
  final String SessionToken;
  final String Region;

  CredentialDetails(this.AccessKey, this.SecretKey, this.SessionToken, this.Region);
}

abstract class CredentialProvider {

  CredentialDetails Credentials();
}


class HardCodedCredentials implements CredentialProvider{

   final CredentialDetails _credentials;

   HardCodedCredentials(String accessKey, String secretKey, {String region="us-east-1", String session = ""}):
    this._credentials = CredentialDetails(accessKey, secretKey,session, region);

  CredentialDetails Credentials() {
    return this._credentials;
  }
}