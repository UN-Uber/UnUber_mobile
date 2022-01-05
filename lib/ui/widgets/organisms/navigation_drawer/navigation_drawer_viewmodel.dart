// Package imports:
import 'package:stacked/stacked.dart';

class NavigationDrawerViewModel extends BaseViewModel {
  String _user = 'user';
  String _email = 'something@something.com';
  String _profileImage = 'assets/images/default_profile_image.png';
  String _landscape = 'assets/images/decoration_landscape.jpg';

  String get user => _user;
  String get email => _email;
  String get profileImage => _profileImage;
  String get landscape => _landscape;
}
