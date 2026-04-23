import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String? token;

Future<http.Response> get(String path, {Map<String, String>? headers}) {
  headers ??= {};
  if (token != null) {
    headers['Authorization'] = 'Bearer ${token!}';
  }
  return http.get(backendUri(path), headers: headers);
}

Future<http.Response> post(
  String path, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) {
  headers ??= {};
  if (token != null) {
    headers['Authorization'] = 'Bearer ${token!}';
  }
  return http.post(
    backendUri(path),
    headers: headers,
    body: body,
    encoding: encoding,
  );
}

Future<http.Response> put(
  String path, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) {
  headers ??= {};
  if (token != null) {
    headers['Authorization'] = 'Bearer ${token!}';
  }
  return http.put(
    backendUri(path),
    headers: headers,
    body: body,
    encoding: encoding,
  );
}

Future<http.Response> patch(
  String path, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) {
  headers ??= {};
  if (token != null) {
    headers['Authorization'] = 'Bearer ${token!}';
  }
  return http.patch(
    backendUri(path),
    headers: headers,
    body: body,
    encoding: encoding,
  );
}

Future<http.Response> delete(
  String path, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) {
  headers ??= {};
  if (token != null) {
    headers['Authorization'] = 'Bearer ${token!}';
  }
  return http.delete(
    backendUri(path),
    headers: headers,
    body: body,
    encoding: encoding,
  );
}

Uri backendUri(String path) {
  return Uri(
    scheme: dotenv.get('BACKEND_SCHEME'),
    host: dotenv.get('BACKEND_HOST'),
    port: dotenv.getInt('BACKEND_PORT'),
    path: path,
  );
}
