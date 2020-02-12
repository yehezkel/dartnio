
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'credentials.dart';
import 'package:convert/convert.dart';


abstract class SigningKeyGenerator {
  List<int> SigningKey(String secretKey, DateTime t, String region, String service);
}

class AwsV4KeyGenerator implements SigningKeyGenerator {

  List<int> SigningKey(String secretKey, DateTime t, String region, String service) {
    final dateStr = "${t.year.toString()}${t.month.toString().padLeft(2,'0')}${t.day.toString().padLeft(2,'0')}";
    return _signer(
        _signer(
          _signer(
            _signer(utf8.encode("AWS4${secretKey}"),dateStr),
            region,
          ),
          service,
        ),
        "aws4_request"
    );
  }
}


abstract class Signer {
  http.Request Sign(http.Request target);
}

class AwsV4HeaderSigner implements Signer {
  
  final CredentialProvider _provider;
  SigningKeyGenerator _keyGenerator;
  
  AwsV4HeaderSigner(this._provider, {SigningKeyGenerator keyGenerator}) {
    this._keyGenerator = keyGenerator ?? AwsV4KeyGenerator();
  }

  http.Request Sign(http.Request target, { DateTime t = null }) {
    var credentials = this._provider.Credentials();
    final algo = "AWS4-HMAC-SHA256";
    final region = credentials.Region;

    var t = DateTime.now().toUtc();
    //if date already set, use it, specially good for testing
    if (target.headers.containsKey("X-Amz-Date")) {
      t = DateTime.parse(target.headers["X-Amz-Date"]);
    }
    
    final hashedPayload = HashedPayload(target.body);
    target.headers["X-Amz-Date"] = ToAwsIso8601(t);
    target.headers["X-Amz-Content-Sha256"] = hashedPayload;
    
    if (credentials.SessionToken != "") {
      target.headers["X-Amz-Security-Token"] = credentials.SessionToken;
    }

    final sheaders = SignedHeaders(target.headers);
    
    final canonicalRequest = <String>[
      target.method,
      "/" + target.url.pathSegments.map(Uri.encodeComponent).join("/"),
      CanonicalStringFromQuery(target.url.queryParameters),
      CanonicalStringFromHeaders(target.headers),
      sheaders,
      hashedPayload,
    ].join("\n");

    final rscope = RequestScope(t,region);

    final stringToSign = <String>[
      algo,
      ToAwsIso8601(t),
      rscope,
      HashedPayload(canonicalRequest),
    ].join("\n");

    final signingKey = this._keyGenerator.SigningKey(credentials.SecretKey,t,region,"s3");
    final signature  = hex.encode(_signer(signingKey, stringToSign));

    final authorization = <String>[
      "${algo} Credential=${credentials.AccessKey}/${rscope}",
      "SignedHeaders=${sheaders}",
      "Signature=${signature}"
    ].join(',');

    target.headers["Authorization"] = authorization;

    return target;
  }
}

String CanonicalStringFromQuery(Map<String,String> query) {
  
  var lowerCase = Map<String,String>();
  
  query.forEach((k,v) {
    lowerCase[k.toLowerCase()] = k;
  });

  
  var keys = lowerCase.keys.toList()
            ..sort();

  final List<String> result = [];    
  keys.forEach((key) {
    result.add(
    "${Uri.encodeComponent(key)}=${Uri.encodeComponent(query[lowerCase[key]])}"
    );
  });

  return result.join('&');
}

String CanonicalStringFromHeaders(Map<String,String> headers) {
  
  var lowerCase = Map<String,String>();
  
  headers.forEach((k,v) {
    lowerCase[k.toLowerCase()] = k;
  });

  
  var keys = lowerCase.keys.toList()
            ..sort();

  final List<String> result = [];    
  keys.forEach((key) {
    result.add(
    "${key}:${headers[lowerCase[key]].trim()}"
    );
  });

  //add final blank line
  result.add("");

  return result.join("\n");
}

String SignedHeaders(Map<String,String> headers) {
  
  var lowerCase = <String>[];
  headers.forEach((k,v) {
    lowerCase.add(k.toLowerCase());
  });

  lowerCase.sort();

  return lowerCase.join(";");
}

String HashedPayload(String payload) {
  return hex.encode(
      sha256.convert(
        utf8.encode(
          payload
        )
      ).bytes
    );
}

String RequestScope(DateTime t, String region) {
  
  final dateStr = "${t.year.toString()}${t.month.toString().padLeft(2,'0')}${t.day.toString().padLeft(2,'0')}";
  return [
    dateStr,region, "s3","aws4_request"
  ].join("/");
}

List<int> _signer(List<int> key, String payload) {
    final hmac = Hmac(sha256,key);
    final d    = hmac.convert(utf8.encode(payload));
    return d.bytes;
}

String ToAwsIso8601(DateTime t) {
  String y = t.year.toString();
  String m = t.month.toString().padLeft(2,'0');
  String d = t.day.toString().padLeft(2,'0');
  String h = t.hour.toString().padLeft(2,'0');
  String min = t.minute.toString().padLeft(2,'0');
  String seg = t.second.toString().padLeft(2,'0');

  return "${y}${m}${d}T${h}${min}${seg}Z";
}

