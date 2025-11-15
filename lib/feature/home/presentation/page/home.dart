// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:hello_bazar/core/util/my_dimens.dart';
import 'package:hello_bazar/feature/dashboard/presentation/page/dashboard_page.dart';
import 'package:hello_bazar/feature/home/presentation/widget/home_navbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pages = [
    DashboardPage(),
    MyDimens().getDemoPage("Message Page"),
    MyDimens().getDemoPage("Documents Page"),
    MyDimens().getDemoPage("Profile Page"),
  ];
  dynamic _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _initialized();
  }

  void _initialized() {
    if (context.mounted) {
      // final data = Provider.of<HomeProvider>(context, listen: false);
      // Future.wait([
      //   Future(() => data.fetchCategories(context)),
      //   Future(() => data.fetchBanners(context)),
      //   Future(() => data.fetchFoodCampaigns(context)),
      //   Future(() => data.fetchPopularProduct(context)),
      //   Future(() => data.fetchHomeRestaurant(ctx: context)),
      // ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentPage, children: _pages),
      bottomNavigationBar: HomeNavbar(
        onPageChange: _onPageChange,
        currentPage: _currentPage,
      ),
    );
  }

  void _onPageChange(int i) {
    setState(() => _currentPage = i);
    IconButton(onPressed: () {}, icon: Icon(Icons.ad_units));
  }
}

// class MessagePage extends StatefulWidget {
//   const MessagePage({super.key});

//   @override
//   State<MessagePage> createState() => _MessagePageState();
// }

// class _MessagePageState extends State<MessagePage> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameField = TextEditingController();
//   final _ageField = TextEditingController();
//   final _categoryField = TextEditingController();

//   String? selected;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Message Page"),
//         backgroundColor: Colors.deepPurple,
//         actions: [
//           Badge.count(
//             count: 15,
//             maxCount: 10,
//             child: Icon(Icons.notifications, color: Colors.white),
//           ), // newly added **maxCount**
//           const SizedBox(width: 20),
//         ],
//       ),
//       body: Padding(
//         padding: const .all(20), // newly added
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: .stretch, // newly added
//             spacing: 15,
//             children: [
//               // name field
//               TextFormField(
//                 controller: _nameField,
//                 decoration: InputDecoration(labelText: "Name"),
//               ),
//               // age field
//               TextFormField(
//                 controller: _ageField,
//                 decoration: InputDecoration(labelText: "Age"),
//               ),
//               //
//               DropdownMenuFormField<String>(
//                 controller: _categoryField,
//                 onSelected: (value) => selected = value,
//                 label: Text("Choose Option"),
//                 dropdownMenuEntries: [
//                   DropdownMenuEntry(value: 'A', label: 'Option A'),
//                   DropdownMenuEntry(value: 'B', label: 'Option B'),
//                   DropdownMenuEntry(value: 'C', label: 'Option C'),
//                 ],
//               ),

//               // TimePickerDialog(initialTime: TimeOfDay.now()),
//               InkWell(
//                 onTap: () {
//                   _formKey.currentState!.reset();
//                   // newly added behavior:
//                   // Text field inside DropdownMenuFormField now clears automatically.
//                 },
//                 onLongPress: () {}, // newly added
//                 child: Text("Reset Form"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameField.dispose();
//     _ageField.dispose();
//     _categoryField.dispose();
//     super.dispose();
//   }
// }

/*

  dynamic _selectedSegment = <int>{2};

SegmentedButton<int>(
                segments: const [
                  ButtonSegment(value: 1, label: Text("Small")),
                  ButtonSegment(value: 2, label: Text("Medium")),
                  ButtonSegment(value: 3, label: Text("Large")),
                ],
                selected: _selectedSegment,
                onSelectionChanged: (value) {
                  setState(() {
                    _selectedSegment = value;
                  });
                },

                style: ButtonStyle(
                  side: WidgetStateProperty.resolveWith(
                    // newly added
                    (states) {
                      if (states.contains(WidgetState.pressed)) {
                        return BorderSide(
                          width: 3,color: Colors.red
                        ); // thicker border when pressed
                      }
                      if (states.contains(WidgetState.focused)) {
                        return BorderSide(width: 10,color: Colors.blue); // highlight border
                      }
                      return BorderSide(width: 1,color: Colors.green.shade300);
                    },
                  ),

                  // background also responds to new WidgetState API
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.blue.withAlpha(40);
                    }
                    return Colors.transparent;
                  }),
                ),

                // newly added behavior:
                // Border now correctly updates its thickness & color based on actual widget state.
              ),
*/
