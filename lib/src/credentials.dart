
class CredentialDetails {
  final String AccessKey;
  final String SecretKey;
  final String SessionToken;

  CredentialDetails(this.AccessKey, this.SecretKey, this.SessionToken);
}

abstract class CredentialProvider {

  CredentialDetails Credentials();
}