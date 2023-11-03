import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_challange/api/api.dart';
import 'package:flutter_challange/models/data_set/data_set.dart';
import 'package:flutter_challange/models/data_set/datum.dart';
import 'package:flutter_challange/models/data_set/device.dart';

import 'constants/app_colors.dart';
import 'constants/app_list.dart';
import 'constants/room_type_eum.dart';
import 'models/room.dart';
import 'views/widgets/room_card.dart';

// import 'constants/app_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List<RoomsNeed> roomslist = [];
  List<Device> totalDevices = [];

  // late List<Device> allRooms;
  // late List<Device> livingRooms;
  // late List<Device> bedRooms;
  // late List<Device> bathRooms;

  @override
  void initState() {
    // allRooms = roomList;
    // livingRooms = roomList
    //     .where((element) => element.roomType == RoomType.living)
    //     .toList();
    // bedRooms =
    //     roomList.where((element) => element.roomType == RoomType.bed).toList();
    // bathRooms =
    //     roomList.where((element) => element.roomType == RoomType.bath).toList();
    Future.delayed(Duration.zero, () async {
      var value = await Api.getData();

      var data = DataSet.fromJson(json.decode(value));

      roomslist = data.data!;

      for (var i in data.data!) {
        totalDevices.addAll(i.devices ?? []);
      }
      isLoading = false;
      setState(() {});
      // livingRooms = data.data[0].devices
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading == false
            ? DefaultTabController(
                length: 4,
                child: Scaffold(
                  backgroundColor: screenBgKColor,
                  body: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 54.0,
                            child: TabBar(
                                labelColor: primaryKColor,
                                indicatorColor: primaryKColor,
                                unselectedLabelColor: textLightKColor,
                                isScrollable: false,
                                labelPadding: EdgeInsets.zero,
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                                tabs: [
                                  Text("All rooms"),
                                  ...List.generate(
                                    roomslist.length,
                                    (index) =>
                                        Text(roomslist[index].title ?? ""),
                                  )
                                ]),
                          ),
                          const SizedBox(height: 24),
                          Expanded(
                            child: TabBarView(
                              children: [
                                GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    crossAxisCount: 2,
                                  ),
                                  itemCount:
                                      totalDevices.length, // Number of items
                                  itemBuilder: (context, ind) {
                                    var item = totalDevices[ind];
                                    return RoomCard(
                                      title: item.displayName ?? "",
                                      subTitle: item.device ?? "",
                                      icon: Icons.abc,
                                      isActive: item.state != null
                                          ? (item.state == 0 ? true : false)
                                          : false,
                                    );
                                  },
                                ),
                                ...List.generate(
                                    roomslist.length,
                                    (index) => GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisSpacing: 8,
                                            mainAxisSpacing: 8,
                                            crossAxisCount: 2,
                                          ),
                                          itemCount: roomslist[index]
                                              .devices!
                                              .length, // Number of items
                                          itemBuilder: (context, ind) {
                                            var item =
                                                roomslist[index].devices![ind];
                                            return RoomCard(
                                              title: item.displayName ?? "",
                                              subTitle: item.device ?? "",
                                              icon: Icons.abc,
                                              isActive: item.state != null
                                                  ? (item.state == 0
                                                      ? true
                                                      : false)
                                                  : false,
                                            );
                                          },
                                        )),
                                // GridView.builder(
                                //   gridDelegate:
                                //       const SliverGridDelegateWithFixedCrossAxisCount(
                                //     crossAxisSpacing: 8,it
                                //     mainAxisSpacing: 8,
                                //     crossAxisCount: 2,
                                //   ),
                                //   itemCount: allRooms.length, // Number of items
                                //   itemBuilder: (context, index) {
                                //     return RoomCard(
                                //       title: allRooms[index].title,
                                //       subTitle: allRooms[index].subTitle,
                                //       icon: allRooms[index].icon,
                                //       isActive: allRooms[index].isActive,

                                //     );
                                //   },
                                // ),
                                // GridView.builder(
                                //   gridDelegate:
                                //       const SliverGridDelegateWithFixedCrossAxisCount(
                                //     crossAxisCount: 2,
                                //   ),
                                //   itemCount: livingRooms.length, // Number of items
                                //   itemBuilder: (context, index) {
                                //     return RoomCard(
                                //       title: livingRooms[index].title,
                                //       subTitle: livingRooms[index].subTitle,
                                //       icon: livingRooms[index].icon,
                                //       isActive: livingRooms[index].isActive,
                                //     );
                                //   },
                                // ),
                                // GridView.builder(
                                //   gridDelegate:
                                //       const SliverGridDelegateWithFixedCrossAxisCount(
                                //     crossAxisCount: 2,
                                //   ),
                                //   itemCount: bedRooms.length, // Number of items
                                //   itemBuilder: (context, index) {
                                //     return RoomCard(
                                //       title: bedRooms[index].title,
                                //       subTitle: bedRooms[index].subTitle,
                                //       icon: bedRooms[index].icon,
                                //       isActive: bedRooms[index].isActive,
                                //     );
                                //   },
                                // ),
                                // GridView.builder(
                                //   gridDelegate:
                                //       const SliverGridDelegateWithFixedCrossAxisCount(
                                //     crossAxisCount: 2,
                                //   ),
                                //   itemCount: bathRooms.length, // Number of items
                                //   itemBuilder: (context, index) {
                                //     return RoomCard(
                                //       title: bathRooms[index].title,
                                //       subTitle: bathRooms[index].subTitle,
                                //       icon: bathRooms[index].icon,
                                //       isActive: bathRooms[index].isActive,
                                //     );
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
