import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

class Service{
 final clint = http.Client();

 static Future<String> loadCertificate()async{
    return await rootBundle.loadString('assets/certificate.crt');
  }


}