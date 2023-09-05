// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:omni_jitsi_meet/jitsi_meet.dart';

// class MetingCall {
//   static joinMeeting(
//       String roomText, String emailText, String nameText, String avatar) async {
//     final String? serverUrl = 'https://live.wowonderflutter.com';

//     final featureFlags = {
//       /*FeatureFlagEnum.ADD_PEOPLE_ENABLED: false,
      
      

//       FeatureFlagEnum.CALENDAR_ENABLED: false,
     
//       FeatureFlagEnum.CHAT_ENABLED: false,
//       FeatureFlagEnum.FULLSCREEN_ENABLED: true,
//       FeatureFlagEnum.IOS_RECORDING_ENABLED: false,
//       FeatureFlagEnum.IOS_SCREENSHARING_ENABLED: false,

//       FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
//       FeatureFlagEnum.NOTIFICATIONS_ENABLED: false,
//       FeatureFlagEnum.PIP_ENABLED: false,
    
  
//       FeatureFlagEnum.REACTIONS_ENABLED: false,
//       FeatureFlagEnum.RECORDING_ENABLED: false,
//       FeatureFlagEnum.REPLACE_PARTICIPANT: false,*/
//       FeatureFlagEnum.RESOLUTION: FeatureFlagVideoResolution.HD_RESOLUTION,
//       /*
//       FeatureFlagEnum.SERVER_URL_CHANGE_ENABLED: false,
   
//       FeatureFlagEnum.TILE_VIEW_ENABLED: true,

//    ,*/
//       // FeatureFlagEnum.AUDIO_FOCUS_DISABLED: false,
//       // FeatureFlagEnum.CONFERENCE_TIMER_ENABLED: true,
//       // FeatureFlagEnum.CHAT_ENABLED: false,
//       // FeatureFlagEnum.SPEAKERSTATS_ENABLED: false,
//       // FeatureFlagEnum.KICK_OUT_ENABLED: false,
//       // FeatureFlagEnum.REPLACE_PARTICIPANT: false,
//       // FeatureFlagEnum.CLOSE_CAPTIONS_ENABLED: true,
//       // FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
//       // FeatureFlagEnum.FILMSTRIP_ENABLED: false,
//       // FeatureFlagEnum.SECURITY_OPTIONS_ENABLED: true,
//       // FeatureFlagEnum.RAISE_HAND_ENABLED: true,
//       // FeatureFlagEnum.LOBBY_MODE_ENABLED: false,
//       // FeatureFlagEnum.LIVE_STREAMING_ENABLED: true,

//       // FeatureFlagEnum.CAR_MODE_ENABLED: false,
//       // FeatureFlagEnum.ADD_PEOPLE_ENABLED: false,
//       // FeatureFlagEnum.MEETING_NAME_ENABLED: false,

//       // FeatureFlagEnum.PREJOIN_PAGE_ENABLED: false,
//       // FeatureFlagEnum.HELP_BUTTON_ENABLED: false,
//       // FeatureFlagEnum.ANDROID_SCREENSHARING_ENABLED: false,
//       // FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
//       // FeatureFlagEnum.OVERFLOW_MENU_ENABLED: false,
//       // FeatureFlagEnum.INVITE_ENABLED: false,
//       // FeatureFlagEnum.AUDIO_MUTE_BUTTON_ENABLED: false,
//       // FeatureFlagEnum.AUDIO_ONLY_BUTTON_ENABLED: false,

//       ///للبث المباشر اخفاء الكاميرا
//       FeatureFlagEnum.VIDEO_SHARE_BUTTON_ENABLED: true,
//       FeatureFlagEnum.SETTINGS_ENABLED: true,
//       FeatureFlagEnum.VIDEO_MUTE_BUTTON_ENABLED: true,
//     };
//     if (!kIsWeb && Platform.isAndroid) {
//       featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
//     }
//     // Define meetings options here
//     final options = JitsiMeetingOptions(
//         userAvatarURL: avatar,
//         room: roomText,
//         serverURL: serverUrl,
//         subject: roomText,
//         userDisplayName: nameText,
//         userEmail: emailText,
//         iosAppBarRGBAColor: null,
//         audioOnly: false,
//         audioMuted: true,
//         videoMuted: false,
//         featureFlags: featureFlags,
//         webOptions: {
//           "roomName": roomText,
//           "width": "100%",
//           "height": "100%",
//           "enableWelcomePage": false,
//           "enableNoAudioDetection": false,
//           "enableNoisyMicDetection": false,
//           "enableClosePage": true,
//           "prejoinPageEnabled": false,
//           "hideConferenceTimer": true,
//           "disableInviteFunctions": false,
//           "chromeExtensionBanner": null,
//           "configOverwrite": {
//             "prejoinPageEnabled": false,
//             "disableDeepLinking": true,
//             "enableLobbyChat": false,
//             "enableClosePage": false,
//             "chromeExtensionBanner": null,
//             /*"toolbarButtons": [
//               "microphone",
//               "camera",
//               "hangup",
//             ]*/
//           },
//           "userInfo": {"email": emailText, "displayName": nameText}
//         });

//     await JitsiMeet.joinMeeting(
//       options,
//       listener: JitsiMeetingListener(
//           onOpened: () {
//             debugPrint("JitsiMeetingListener - onOpened");
//           },
//           onClosed: () {
//             debugPrint("JitsiMeetingListener - onClosed");
//           },
//           onError: (error) {
//             debugPrint("JitsiMeetingListener - onError: error: $error");
//           },
//           onConferenceWillJoin: (url) {
//             debugPrint(
//                 "JitsiMeetingListener - onConferenceWillJoin: url: $url");
//           },
//           onConferenceJoined: (url) {
//             debugPrint("JitsiMeetingListener - onConferenceJoined: url:$url");
//           },
//           onConferenceTerminated: (url, error) {
//             debugPrint(
//                 "JitsiMeetingListener - onConferenceTerminated: url: $url, error: $error");
//           },
//           onParticipantLeft: (participantId) {
//             debugPrint(
//                 "JitsiMeetingListener - onParticipantLeft: $participantId");
//           },
//           onParticipantJoined: (email, name, role, participantId) {
//             debugPrint("JitsiMeetingListener - onParticipantJoined: "
//                 "email: $email, name: $name, role: $role, "
//                 "participantId: $participantId");
//           },
//           onAudioMutedChanged: (muted) {
//             debugPrint(
//                 "JitsiMeetingListener - onAudioMutedChanged: muted: $muted");
//           },
//           onVideoMutedChanged: (muted) {
//             debugPrint(
//                 "JitsiMeetingListener - onVideoMutedChanged: muted: $muted");
//           },
//           onScreenShareToggled: (participantId, isSharing) {
//             debugPrint("JitsiMeetingListener - onScreenShareToggled: "
//                 "participantId: $participantId, isSharing: $isSharing");
//           },
//           genericListeners: [
//             JitsiGenericListener(
//                 eventName: 'readyToClose',
//                 callback: (dynamic message) {
//                   debugPrint("JitsiMeetingListener - readyToClose callback");
//                 }),
//           ]),
//     );
//   }
// }
