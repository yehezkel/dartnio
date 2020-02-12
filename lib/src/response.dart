
import "package:http/http.dart" as http;

class ApiResponse {

  Future<http.StreamedResponse> f;
  http.StreamedResponse realResponse;
  var _error;
  var _done = false;
  
  ApiResponse(Future<http.StreamedResponse> response) {
    this.f = response;
    
    this.f.then((resp) {
      this.realResponse = resp;
      print(resp);
      return http.Response.fromStream(resp);
    })
    .then((resp) {
      print(resp.body);
      print(resp.statusCode);
      print(resp.headers);
      print(resp.request.headers);
    })
    .catchError((error) {      
      this._error = error;
    })
    .whenComplete(() {
      print("completed on response");
      this._done = true;
    });
  }


}