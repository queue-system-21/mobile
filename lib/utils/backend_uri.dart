import 'package:flutter_dotenv/flutter_dotenv.dart';

Uri backendUri(String path) {
  return Uri(
    scheme: dotenv.get('BACKEND_SCHEME'),
    host: dotenv.get('BACKEND_HOST'),
    port: dotenv.getInt('BACKEND_PORT'),
    path: path,
  );
}