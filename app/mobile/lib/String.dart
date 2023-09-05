import 'package:wowondertimelineflutterapp/FlutterCraftersKey.dart';
import 'package:wowondertimelineflutterapp/language/fa.dart';

const String nameApp = 'WoWonder Flutter';

const String onesignalKey = '0c316cc9-19fe-4eb7-887d-178e1f5f40bc';
//v4.0.9

// NodeJs or Port
const bool NodeJS = true;
const String NodeJs_Port = '4449';

///chat Gpt https://platform.openai.com/apps Get key
const String ChatGpt_API_KEY = "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";

/// Setting More Options
const bool Albums = true;
const bool SavedPosts = true;
const bool FriendsFollowers = true;
const bool Groups = true;
const bool Memories = true;
const bool MyVideo = true;
const bool MarketPlace = true;
const bool Events = true;
const bool Jobs = true;
const bool Pages = true;
const bool Offers = true;
const bool MyImages = true;
const bool Boosted = true;
const bool Advertising = true;
const bool Pokes = true;
const bool Movies = true;
const bool Earnings = true;
const bool InvitationLinks = true;

const bool Reels = false;

const bool Enable_Profile_Share = true;

/// Turn on Ads on app
const bool Active_Admob_Ads = true;
const bool Active_AdmobBanner = true;

/// Make you change the App Id in AndroidManifest.xml
/// Android Banner ID
const String ADMOB_ANDROID_BANNER_ID = 'ca-app-pub-9483238061194787/9160511747';

/// iOS Banner ID
const String ADMOB_IOS_BANNER_ID = 'ca-app-pub-9483238061194787~1465854555';

/// 1 for Old Theme, 2 for New Theme
const int Story_Theme_Version = 2;
//seconds 30
const int Story_Max_Upload = 30;

/// Change App icons to Color icons
const bool Change_Color_Icons = false;

/// Agora App ID for Calling and LiveStreaming
const Agora_App_ID = '6a1fcb8a44454844a9b46b271d637e7f';

/// Activate Audio Video Call using agora
const bool Activate_Audio_Calls = true;
const bool Activate_Video_Calls = true;

/// Activate a conference call for package subscribers
const bool Group_Call_for_Pro_Users = true;

/// The ID of the package in which you want to enable the meeting
const String IdPackageCall = '0'; /// In Next Update

/// RateMyApp Dialogue
const String PackageAndroid = 'app.wowonderflutter.com';
const String IOSid = '1663370110';

/// If you want to Add Friend System Then make it true.
const bool Friends_System = false;

/// To Show or Hide the Social Media Links on Profile
const bool Social_Links = true;

/// To Show or Hide the Social Media Logins Buttons
const bool Social_Login_Page = true;

///Log in with Google || true || false
const bool Login_With_Google = true;

///Log in with Facebook || true || false
const bool Login_With_Facebook = true;

///login with Apple
const bool Login_With_Apple = true;

///The number of publications that are fetched in the main screen in each update
const String Home_Post_Limit = '20';

///true false copy text
const bool Copy_Post_Text = true;

///ffmpeg
const bool FFmpeg = true;

//The running time of the video in the story

////Timer Resend Code OTP
//seconds 30
const int OTP_Resend_Timer = 30;

//

/// Checks if string is an video file.
///       ext.endsWith(".avi") ||
/// Video playback formats have been added here
bool VideoEx(String filePath) {
  var ext = filePath.toLowerCase();

  return ext.endsWith(".mp4") ||
      ext.endsWith(".avi") ||
      ext.endsWith(".wmv") ||
      ext.endsWith(".rmvb") ||
      ext.endsWith(".mpg") ||
      ext.endsWith(".mov") ||
      ext.endsWith(".mpeg") ||
      ext.endsWith(".3gp");
}

String keyWowo = FlutterCraftersKey;
