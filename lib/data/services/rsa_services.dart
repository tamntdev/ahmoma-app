// import 'package:encrypt/encrypt.dart' as encrypt_package;
// import 'package:encrypt/encrypt.dart';
// import 'package:flutter/services.dart';
// import 'package:pointycastle/export.dart';
//
// class RSAService {
//   static RSAService instance = RSAService._();
//
//   RSAService._();
//
//   RSAPublicKey? publicKey;
//   RSAPrivateKey? privateKey;
//
//   /// ENCRYPT DATA
//   Future<String> encryptData(String data) async {
//     await rsaKeyParse();
//
//     // publicKey ??= await parseKeyFromFile<RSAPublicKey>('assets/public.pem');
//     // privateKey ??= await parseKeyFromFile<RSAPrivateKey>('assets/private.pem');
//
//     final encrypter = encrypt_package.Encrypter(
//         encrypt_package.RSA(publicKey: publicKey, privateKey: privateKey));
//
//     return encrypter.encrypt(data).base64;
//   }
//
//   Future<String> decryptData(String encrypted64) async {
//     await rsaKeyParse();
//     final encrypter = encrypt_package.Encrypter(
//         encrypt_package.RSA(publicKey: publicKey, privateKey: privateKey));
//     encrypter.decrypt64(encrypted64);
//     return encrypter.decrypt64(encrypted64);
//   }
//
//   Future<void> rsaKeyParse() async {
//     if (publicKey == null || privateKey == null) {
//       encrypt_package.RSAKeyParser parser = encrypt_package.RSAKeyParser();
//       final publicPem = await rootBundle.loadString('assets/public.pem');
//       final privatePem = await rootBundle.loadString('assets/private.pem');
//       publicKey ??= parser.parse(publicPem) as RSAPublicKey;
//       privateKey ??= parser.parse(privatePem) as RSAPrivateKey;
//     }
//   }
//
//   /// Đọc dữ liệu từ file public key
//   Future<String> readPublicKeyFromFile() async {
//     return await rootBundle.loadString('assets/public_key.pem');
//   }
//
//   /// Hàm mã hóa mật khẩu
//   String encryptPassword(String password, String publicKeyPEM) {
//     final parser = encrypt_package.RSAKeyParser();
//     final publicKey = parser.parse(publicKeyPEM) as RSAPublicKey;
//
//     final encrypter = encrypt_package.Encrypter(
//         encrypt_package.RSA(publicKey: publicKey, encoding: RSAEncoding.OAEP));
//
//     final encrypted = encrypter.encrypt(password);
//     return encrypted.base64;
//   }
//
//   Future<String> encryptPasswordWithPublicKey(String password) async {
//     // Đọc khóa công khai từ tệp
//     final publicKeyPEM = await readPublicKeyFromFile();
//
//     // Mã hóa mật khẩu bằng public key từ server
//     final encryptedPassword = encryptPassword(password, publicKeyPEM);
//
//     return encryptedPassword;
//   }
// }
