
//temporal container just to identify all the common/require components
class ApiRequest {
  Map<String,dynamic> _options;
  
  ApiRequest(this._options);

  dynamic Lookup(String key, {dynamic defvalue = null }) {

    if (this._options.containsKey(key)) {
      return this._options[key];
    }

    return defvalue;
  }

  bool containsKey(String key) {
    return this._options.containsKey(key);
  }
}