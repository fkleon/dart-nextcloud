import 'dart:convert';
import 'dart:io';

import 'package:nextcloud/nextcloud.dart';

class Config {
  const Config({
    this.host,
    this.username,
    this.password,
    this.shareUser,
    this.testDir,
    this.image,
    this.token,
  });

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        host: json['host'],
        username: json['username'],
        password: json['password'],
        shareUser: json['shareUser'],
        testDir: json['testDir'],
        image: json['image'],
        token: json['token'],
      );

  final String host;
  final String username;
  final String password;
  final String shareUser;
  final String testDir;
  final String image;
  final String token;
}

Config getConfig() =>
    Config.fromJson(json.decode(File('config.json').readAsStringSync()));

NextCloudClient getClient(Config config) => NextCloudClient.withCredentials(
      config.host,
      config.username,
      config.password,
    );

void main() {
  // Stub
}
