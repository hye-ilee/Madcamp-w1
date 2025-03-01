import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:phone_demo/helpers/database_helper.dart';
import 'package:phone_demo/helpers/kakao_map_helper.dart';
import 'dart:convert';

LatLng parseLocation(String location) {
  final parts = location.split(',').map((e) => e.trim()).toList();
  if (parts.length == 2) {
    final latitude = double.tryParse(parts[0]) ?? 0.0;
    final longitude = double.tryParse(parts[1]) ?? 0.0;
    return LatLng(latitude, longitude);
  }
  return const LatLng(0.0, 0.0); // Default fallback if parsing fails
}

void showCafeInfoPopup(BuildContext context, Map<String, dynamic> cafe) async {
  final userInfo = await DatabaseHelper.instance.fetchUserInfo(1);
  List<String> jjims = [];
  if (userInfo != null) {
    jjims = List<String>.from(
      jsonDecode(userInfo['jjim_list']),
    );
  }
  bool isFavorite = jjims.contains(cafe['kakao_id']);
  final LatLng cafeLocation = parseLocation(cafe['location']);
  GoogleMapController? mapController;

  // Offset to move the marker away from the center
  const double verticalOffset = 0.005; // Adjust this for up/down positioning
  const double horizontalOffset =
      0.000; // Adjust this for left/right positioning

  final List<String> cafeImages =
      (cafe['images'] as String).split(',').map((e) => e.trim()).toList();

  // Scraped menu list (simulate scraping or fetching from the database)
  final List<String> menuList =
      (cafe['menus'] as String).split(',').map((e) => e.trim()).toList();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Stack(
            children: [
              Positioned.fill(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      cafeLocation.latitude - verticalOffset,
                      cafeLocation.longitude + horizontalOffset,
                    ),
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(cafe['kakao_id']),
                      position: cafeLocation,
                      infoWindow: InfoWindow(title: cafe['name']),
                    ),
                  },
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.5, // Half screen height initially
                minChildSize: 0.3, // Minimum height
                maxChildSize: 1.0, // Full screen height
                builder: (context, scrollController) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                      ),
                    ),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        // Cafe name with the star button aligned
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cafe['name'],
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            IconButton(
                              icon: Icon(
                                isFavorite ? Icons.star : Icons.star_border,
                                color: isFavorite ? Colors.yellow : null,
                              ),
                              onPressed: () async {
                                setState(() {
                                  isFavorite = !isFavorite;
                                });

                                // Update jjim_list in the database
                                if (isFavorite) {
                                  jjims.add(cafe['kakao_id']);
                                } else {
                                  jjims.remove(cafe['kakao_id']);
                                }

                                if (userInfo != null) {
                                  userInfo["jjim_list"] = jsonEncode(jjims);
                                  await DatabaseHelper.instance
                                      .updateUserInfo(userInfo);
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text('Phone: ${cafe['phone']}'),
                        const SizedBox(height: 16.0),

                        // Map-related buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                KakaoMapHelper.openKakaoPlaceWithId(
                                    cafe['kakao_id']);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.brown,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                              ),
                              child: const Text('지도 보기'),
                            ),
                            const SizedBox(width: 8.0),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.brown,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                              ),
                              child: const Text('닫기'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),

                        // Cafe images as a swipable gallery
                        SizedBox(
                          height: 200.0, // Adjust height as needed
                          child: PageView.builder(
                            itemCount: cafeImages.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    cafeImages[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),

                        // Scrollable menu list
                        Text(
                          '메뉴',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8.0),
                        SizedBox(
                          height: 150.0,
                          child: ListView.builder(
                            itemCount: menuList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(menuList[index]),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    },
  );
}
