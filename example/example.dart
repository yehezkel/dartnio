
import "package:http/http.dart" as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:convert/convert.dart';

/*void main() {
   
  var request = http.Request("GET", Uri.parse("https://www.google.com"));
  var client = http.Client();
  client.send(request).then((response) {
    print(response.statusCode);
    return http.Response.fromStream(response);
  })
  .then((response) {
    print(response.body);
  })
  .catchError((error)  {
    print(error);
  }).whenComplete(() {
    client.close(); 
  });

  print("finishing");
}*/ 

/*void main() {
   
  var test = "https://www.example.com/ps1/ps2?cA=1&b=2&ac=2%20a";
  var parsed = Uri.parse(test);

  final query = parsed.queryParameters;
  final c = TestC(query);
  print(TestC(query));
  print(TestC(query, keyValueGlue: ":", linesGlue:"\n"));
  print(parsed.path);
}

String TestC(Map<String,String> query,{String keyValueGlue = "=", String linesGlue = "&"}) {
  
  var lowerCase = Map<String,String>();
  
  query.forEach((k,v) {
    lowerCase[k.toLowerCase()] = k;
  });

  
  var keys = lowerCase.keys.toList()
            ..sort();

  final List<String> result = [];    
  keys.forEach((key) {
    result.add(
    "${Uri.encodeComponent(key)}${keyValueGlue}${Uri.encodeComponent(query[lowerCase[key]])}"
    );
  });

  return result.join(linesGlue);
}*/

void main() {
  print(HashedPayload(""));
}

String HashedPayload(String payload) {
  return hex.encode(
      sha256.convert(
        utf8.encode(
          payload.toString()
        )
      ).bytes
    );
}
