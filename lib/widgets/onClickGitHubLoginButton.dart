import 'secret_keys.dart' as SecretKey;
import 'package:url_launcher/url_launcher.dart';
//..
void onClickGitHubLoginButton() async {
  const String url = "https://github.com/login/oauth/authorize" +
      "?client_id=" + SecretKey.GITHUB_CLIENT_ID +
      "&scope=public_repo%20read:user%20user:email";
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else {
    print("CANNOT LAUNCH THIS URL!");
  }
}