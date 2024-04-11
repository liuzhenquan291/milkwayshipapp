import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:encrypt/encrypt.dart';
import 'package:intl/intl.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';

class EncrypterController extends GetxController {
  static EncrypterController get to => Get.find();

  // final RSAPublicKey publicKey = parsePublicKeyFromPemFile() as RSAPublicKey;

  encryptRSA(String plainText) async {
    // 非对称加密
    // if (_rsa == null) {
    //   final Encrypter rsa = Encrypter(RSA(publicKey: publicKey));
    //   _rsa = rsa;
    // }
    // return _rsa.encrypt(plainText);
    return plainText;
  }

  encryptMd5(String plainText) {
    // md5 加密数据
    // Convert the input string to bytes
    List<int> inputBytes = utf8.encode(plainText);
    // Generate the MD5 hash
    Digest md5Hash = md5.convert(inputBytes);

    // Convert the hash to a hex string
    String hexHash = md5Hash.toString();

    return hexHash;
  }
}

Future<RSAPublicKey> parsePublicKeyFromPemFile() async {
  final directory = await getApplicationDocumentsDirectory();
  String path = directory.path;
  final File file = File('$path/.pub.pem');
  final String pemString = file.readAsStringSync();

  final parser = RSAKeyParser();
  final RSAPublicKey publicKey = parser.parse(pemString) as RSAPublicKey;

  return publicKey;
}

final formatter_1 = DateFormat("yyyy-MM-dd HH:mm:ss");

String formatDateTime_1(DateTime? dateTime) {
  if (dateTime == null) {
    return "";
  }
  return formatter_1.format(dateTime);
}
