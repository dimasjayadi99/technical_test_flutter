import 'package:package_info_plus/package_info_plus.dart';

class AppVersionUtils {
  getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}