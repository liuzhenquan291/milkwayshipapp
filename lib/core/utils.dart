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
final formatter_2 = DateFormat("yyyy-MM-dd");
final formatter_3 = DateFormat("yy-MM-dd HH 时");

String formatDateTime_1(DateTime? dateTime) {
  if (dateTime == null) {
    return "";
  }
  return formatter_1.format(dateTime);
}

String formatDateTime_2(DateTime? dateTime) {
  if (dateTime == null) {
    return "";
  }
  return formatter_2.format(dateTime);
}

String formatDateTime_3(DateTime? dateTime) {
  if (dateTime == null) {
    return "";
  }
  return formatter_3.format(dateTime);
}

const Map<int, String> weekDayMap = {
  7: '周日',
  1: '周一',
  2: '周二',
  3: '周三',
  4: '周四',
  5: '周五',
  6: '周六',
};

String formatDateTime_4(DateTime? dateTime) {
  // 获取周几几时
  if (dateTime == null) {
    return "";
  }
  final weekDay = dateTime.weekday;
  String str = weekDayMap[weekDay] ?? '';
  final hour = dateTime.hour;
  String hourStr = '';
  if (hour <= 9) {
    hourStr = "0$hour时";
  } else {
    hourStr = "$hour时";
  }
  return "$str$hourStr";
}
