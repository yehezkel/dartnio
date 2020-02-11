
import "package:http/http.dart" as http;

void main() {
   
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
}