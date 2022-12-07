import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';

class RecoveryService {
  static const _typeSid = 16;
  static const _typeK = 64;
  static const _typeFg = 64;

  static const _validChars = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
  ];

  static const infoProduct = 'AP';
  static const infoImageLink = 'AU';
  static const infoImageHash = 'AH';
  static const infoImageSess = 'AT';
  static const infoSignLink = 'CU';
  static const infoSignHash = 'CH';
  static const infoSignSess = 'CT';
  static const infoRequired = [
    infoProduct,
    infoImageLink,
    infoImageHash,
    infoImageSess,
    infoSignLink,
    infoSignHash,
    infoSignSess
  ];

  Future<String?> requestSession() async {
    final response = await Client().get(
      Uri.parse('http://osrecovery.apple.com/'),
      headers: {
        'Host': 'osrecovery.apple.com',
        'Connection': 'close',
        'User-Agent': 'InternetRecovery/1.0',
      },
    );

    final cookieHeader = response.headers['set-cookie'];
    final cookies = cookieHeader?.split('; ');

    return cookies?.firstWhere((cookie) => cookie.startsWith('session='));
  }

  Future<Map<String, String>> requestDetails({
    required String mlb,
    required String boardId,
    required String session,
  }) async {
    final response = await Client().post(
      Uri.parse(
          'http://osrecovery.apple.com/InstallationPayload/RecoveryImage'),
      headers: {
        'Host': 'osrecovery.apple.com',
        'Connection': 'close',
        'User-Agent': 'InternetRecovery/1.0',
        'Cookie': session,
        'Content-Type': 'text/plain',
      },
      body: utf8.encode(
        '''
cid=${_generateId(_typeSid)}
sn=$mlb
bid=$boardId
k=${_generateId(_typeK)}
fg=${_generateId(_typeFg)},
os=default
''',
      ),
    );

    final output = response.body;
    final info = <String, String>{};

    for (var line in output.split('\n')) {
      final split = line.split(': ');

      if (split.length >= 2) {
        final key = split[0];
        final value = split[1];
        info[key] = value;
      }
    }

    for (var k in infoRequired) {
      if (!info.containsKey(k)) {
        throw Exception('Missing key $k');
      }
    }

    return info;
  }

  Future<StreamedResponse> requestFile({
    required String url,
    required String session,
  }) async {
    final uri = Uri.parse(url);

    final request = Request(
      'GET',
      uri,
    );

    request.headers.addAll({
      'Host': uri.host,
      'Connection': 'close',
      'User-Agent': 'InternetRecovery/1.0',
      'Cookie': ['AssetToken', session].join('=')
    });

    return await Client().send(request);
  }

  String _generateId(length) => List.generate(
        length,
        (index) => _validChars[Random().nextInt(_validChars.length)],
      ).join();
}
