import 'package:hello_bazar/core/constants/my_icon.dart';
import 'package:hello_bazar/feature/common/data/model/cm_user.dart';

class MyConstants {
  static const List<String> navItemImages = [
    MyIcon.home1,
    // MyIcon.search1,
    // MyIcon.message1,
    // MyIcon.file1,
    MyIcon.user1,
  ];
  static const navItemSelectedImages = [
    MyIcon.home2,
    //   MyIcon.search2,
    // MyIcon.message2,
    // MyIcon.file2,
    MyIcon.user2,
  ];

  static const List<String> genderList = ["Male", "Female", "Saiful"];

  static List<CmUser> demoUsers = [
    CmUser(
      id: '1',
      title: 'Alex Johnson',
      image: 'https://randomuser.me/api/portraits/men/1.jpg',
      gender: 'male',
      mobileNo: "12345678901"
    ),
    CmUser(
      id: '2',
      title: 'Sarah Williams',
      image: 'https://randomuser.me/api/portraits/women/1.jpg',
      gender: 'female',
      mobileNo: "12345678902"
    ),
    CmUser(
      id: '3',
      title: 'Michael Chen',
      image: 'https://randomuser.me/api/portraits/men/2.jpg',
      gender: 'male',
      mobileNo: "12345678903"
    ),
    CmUser(
      id: '4',
      title: 'Emma Rodriguez',
      image: 'https://randomuser.me/api/portraits/women/2.jpg',
      gender: 'female',
      mobileNo: "12345678904"
    ),
    CmUser(
      id: '5',
      title: 'David Smith',
      image: 'https://randomuser.me/api/portraits/men/3.jpg',
      gender: 'male',
      mobileNo: "12345678905"
    ),
  ];
}
