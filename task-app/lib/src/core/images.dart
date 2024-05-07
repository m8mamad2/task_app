
import 'dart:developer';

const String kProfileImage1 = 'assets/profile/1.png';
const String kProfileImage2 = 'assets/profile/2.png';
const String kProfileImage3 = 'assets/profile/3.png';
const String kProfileImage4 = 'assets/profile/4.png';
const String kProfileImage5 = 'assets/profile/5.png';
const String kProfileImage6 = 'assets/profile/6.png';
const String kProfileImage7 = 'assets/profile/7.png';
const String kProfileImage8 = 'assets/profile/8.png';

final List<String> kProfileImages = [ kProfileImage1, kProfileImage2, kProfileImage3, kProfileImage4, kProfileImage5, kProfileImage6, kProfileImage7, kProfileImage8, ];

String finalImage(int numb){
    switch(numb){
      case 0: return kProfileImage1;
      case 1: return kProfileImage2;
      case 2: return kProfileImage3;
      case 3: return kProfileImage4;
      case 4: return kProfileImage5;
      case 5: return kProfileImage6; 
      case 6: return kProfileImage7; 
      case 7: return kProfileImage8;
      default:return kProfileImage1;
    }
}