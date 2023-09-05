import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/String.dart';

class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Always Connected Anywhere Anytime'.tr,
      image: images.onBording1,
      discription:
          'By using the ${nameApp} platform you can always be connected anywhere anytime.'
              .tr),
  UnbordingContent(
      title: 'Fast like a scream',
      image: images.omBording2,
      discription:
          'Enjoy your surfing experience on the ${nameApp} with your new friends from all over the world.'),
  UnbordingContent(
      title: 'Discover Interesting Things Every Day',
      image: images.onbBording3,
      discription:
          'You can get new and interesting things every day even every second when you start scrolling.'),
];
