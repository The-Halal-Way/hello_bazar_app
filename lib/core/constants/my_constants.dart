import 'package:hello_bazar/core/constants/my_icon.dart';
import 'package:hello_bazar/feature/common/data/model/cm_user.dart';

class MyConstants {
  static const List<String> navItemImages = [
    MyIcon.home1,
    //MyIcon.search1,
    //MyIcon.message1,
    MyIcon.file1,
    MyIcon.user1,
  ];
  static const navItemSelectedImages = [
    MyIcon.home2,
    //MyIcon.search2,
    //MyIcon.message2,
    MyIcon.file2,
    MyIcon.user2,
  ];

  static const List<String> genderList = ["Male", "Female", "Saiful"];

  static List<CmUser> demoUsers = [
    CmUser(
      id: '1',
      name: 'Alex Johnson',
      image: 'https://randomuser.me/api/portraits/men/1.jpg',
      gender: 'male',
      mobileNo: "12345678901",
      email: "12345678901@gmail.com",
      isVerified: true,
      joinDate: DateTime.now(),
    ),
    CmUser(
      id: '2',
      name: 'Sarah Williams',
      image: 'https://randomuser.me/api/portraits/women/1.jpg',
      gender: 'female',
      mobileNo: "12345678902",
      email: "12345678902@gmail.com",
      isVerified: true,
      joinDate: DateTime.now(),
    ),
    CmUser(
      id: '3',
      name: 'Michael Chen',
      image: 'https://randomuser.me/api/portraits/men/2.jpg',
      gender: 'male',
      mobileNo: "12345678903",
      email: "12345678903@gmail.com",
      isVerified: true,
      joinDate: DateTime.now(),
    ),
    CmUser(
      id: '4',
      name: 'Emma Rodriguez',
      image: 'https://randomuser.me/api/portraits/women/2.jpg',
      gender: 'female',
      mobileNo: "12345678904",
      email: "12345678904@gmail.com",
      isVerified: true,
      joinDate: DateTime.now(),
    ),
    CmUser(
      id: '5',
      name: 'David Smith',
      image: 'https://randomuser.me/api/portraits/men/3.jpg',
      gender: 'male',
      mobileNo: "12345678905",
      email: "12345678905@gmail.com",
      isVerified: true,
      joinDate: DateTime.now(),
    ),
  ];
}
