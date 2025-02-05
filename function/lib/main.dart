import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<dynamic> main(final context) async {
  final tenentID = Platform.environment['TENENT_ID'] ?? "";
  final clientID = Platform.environment['CLIENT_ID'] ?? "";
  final clientSecret = Platform.environment['CLIENT_SECRET'] ?? "";

  final authUrl = Uri.parse("https://login.microsoftonline.com/${tenentID}/oauth2/v2.0/token");

  final body = {
    "client_id": clientID,
    "client_secret": clientSecret,
    "grant_type": "client_credentials",
    "scope": "https://graph.microsoft.com/.default",
  };

  if (context.req.path == "/ping") {
    return context.res.text('Pong');
  }

  if (context.req.path == "/access-token") {
    final response = await http.post(authUrl, body: body);
    return context.res.json(response.body);
  }

  return context.res.json({
    'motto': 'Build like a team of hundreds_',
    'learn': 'https://appwrite.io/docs',
    'connect': 'https://appwrite.io/discord',
    'getInspired': 'https://builtwith.appwrite.io',
  });
}
