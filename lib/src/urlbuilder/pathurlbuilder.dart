
import '../urlbuilder.dart';


class PathUrlBuilder implements UrlBuilder {

  final String _hostname;

  PathUrlBuilder(this._hostname);

  String BuildUrl(String bucket, String object, String location) {
    return "${this._hostname}/${bucket}";
  }
}