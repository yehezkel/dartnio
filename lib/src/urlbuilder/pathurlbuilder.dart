
import '../urlbuilder.dart';


class PathUrlBuilder implements UrlBuilder {

  final String _hostname;

  PathUrlBuilder(this._hostname);

  String BuildUrl(String bucket, String object, String location) {

    var result = this._hostname;
    if( !(bucket?.isEmpty ?? true) ) {
      result += "/${bucket}";

      if (!(object?.isEmpty ?? true)){
        result += "/${object}";
      }
    }
    return result;
  }
}