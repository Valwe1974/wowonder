import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/NameScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/NavBar/HomeNavBar.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiSocialLogin.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class AppleLogin2 extends StatefulWidget {
  const AppleLogin2({Key? key}) : super(key: key);

  @override
  _AppleLoginState createState() => _AppleLoginState();
}

class _AppleLoginState extends State<AppleLogin2> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // final credential = await SignInWithApple.getAppleIDCredential(
        //   scopes: [
        //     AppleIDAuthorizationScopes.email,
        //     AppleIDAuthorizationScopes.fullName,
        //   ],
        // );

        if (GetPlatform.isIOS) {
          final credential = await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],

            // // TODO: Remove these if you have no need for them
            // nonce: 'example-nonce',
            // state: 'example-state',
          );
          SignInWithApple.channel;
          if (credential != null) {
            var tok = await ApiSocialLogin.lgin(
                'apple', credential.identityToken.toString());
            print(tok.toString());
            if (tok['is_new']) {
              SharedP.Save('tok', tok['access_token'].toString());
              SharedP.Save('user_id', tok['user_id'].toString());
              Get.offAll(NameScreen());
              print('new');
            } else {
              SharedP.Save('tok', tok['access_token'].toString());
              SharedP.Save('user_id', tok['user_id'].toString());
              Get.offAll(HomeNavBar());
            }
          }

          print(credential.identityToken.toString());
        }

        if (GetPlatform.isAndroid) {
          var redirectURL =
              "${accounts[0]['sm0']}/callbacks/sign_in_with_apple";
          var clientID = "QRC29SLNN3";
          final appleIdCredential = await SignInWithApple.getAppleIDCredential(
              scopes: [
                AppleIDAuthorizationScopes.email,
                AppleIDAuthorizationScopes.fullName,
              ],
              webAuthenticationOptions: WebAuthenticationOptions(
                  clientId: clientID, redirectUri: Uri.parse(redirectURL)));
          // final oAuthProvider = OAuthProvider(providerId: 'apple.com');
          // final credential = oAuthProvider.getCredential(
          //   idToken: appleIdCredential.identityToken,
          //   accessToken: appleIdCredential.authorizationCode,
          // );
          // final authResult =
          //     await SignInUtil.firebaseAuth.signInWithCredential(credential);
          // return authResult.user;
        }
        // This is the endpoint that will convert an authorization code obtained
        // via Sign in with Apple into a session in your system
        // final signInWithAppleEndpoint = Uri(
        //   scheme: 'https',
        //   host: 'flutter-sign-in-with-apple-example.glitch.me',
        //   path: '/sign_in_with_apple',
        //   queryParameters: <String, String>{
        //     'code': credential.authorizationCode,
        //     if (credential.givenName != null)
        //       'firstName': credential.givenName!,
        //     if (credential.familyName != null)
        //       'lastName': credential.familyName!,
        //     'useBundleId': !kIsWeb && (Platform.isIOS || Platform.isMacOS)
        //         ? 'true'
        //         : 'false',
        //     if (credential.state != null) 'state': credential.state!,
        //   },
        // );

        // final session = await http.Client().post(
        //   signInWithAppleEndpoint,
        // );
      },
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: Get.height * 0.07,
          width: Get.width * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Get.isDarkMode ? Colors.black : Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/ImageNew/apple-big-logo-svgrepo-com.svg',
                height: 30,
                width: 30,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              // Text(
              //   'Facebook'.tr,
              //   style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
