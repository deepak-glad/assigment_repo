import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testproject/controller/constant.dart';
import 'package:testproject/model/GetDishesProductModel.dart';
import 'package:testproject/view/second_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selceIndexCategory = 0;

  @override
  void initState() {
    getDishesApiData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Select Dishes",
              style: TextStyle(color: Colors.black, fontSize: 16)),
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 1),
      body: FutureBuilder<GetDishesProduct>(
          future: getDishesApiData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data!.dishes.isEmpty) {
              return const Center(
                  child: Text(
                "No Data Found",
                style: TextStyle(color: Colors.black, fontSize: 18.5),
              ));
            } else {
              return Stack(alignment: Alignment.bottomCenter, children: [
                ListView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: 100,
                        child: Stack(children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 150,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 60,
                              decoration:
                                  const BoxDecoration(color: Colors.black),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              height: 65,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey, blurRadius: 1.5)
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/image/Select_date-01@2x.png',
                                        height: 20,
                                      ),
                                      const Text(
                                        "    21 May 2021",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 20,
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/image/Set_time-01@2x.png',
                                        height: 20,
                                      ),
                                      const Text(
                                        "    10:30 Pm - 12:30 Pm",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 30,
                        child: ListView.builder(
                            itemCount: 6,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selceIndexCategory = index;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: selceIndexCategory == index
                                          ? const Color(0xffFFF9F2)
                                          : null,
                                      border: Border.all(
                                          color: selceIndexCategory == index
                                              ? const Color(0xffFF941A)
                                              : const Color(0xffBDBDBD))),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  child: Text(
                                    "Indian",
                                    style: TextStyle(
                                        color: selceIndexCategory == index
                                            ? const Color(0xffFF941A)
                                            : const Color(0xffBDBDBD),
                                        fontSize: 12,
                                        fontWeight: selceIndexCategory == index
                                            ? FontWeight.w500
                                            : FontWeight.normal),
                                  ),
                                ),
                              );
                            }),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "   Popular Dishes",
                        style: TextStyle(
                            color: Color(0xff1C1C1C),
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 83,
                        child: ListView.builder(
                            itemCount: snapshot.data!.popularDishes.length,
                            padding: const EdgeInsets.only(left: 10),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var popularDishes =
                                  snapshot.data!.popularDishes[index];
                              return CircleAvatar(
                                radius: 45,
                                backgroundColor: selceIndexCategory != index
                                    ? Colors.orange
                                    : Colors.transparent,
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 40,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  // colorFilter: Color,
                                                  // colorFilter: color,
                                                  // colorBlendMode: BlendMode.hardLight,
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.black
                                                          .withOpacity(0.5),
                                                      BlendMode.darken),
                                                  image: NetworkImage(
                                                      popularDishes.image)),
                                              color: Colors.black,
                                              shape: BoxShape.circle),
                                        ),
                                        Text(
                                          popularDishes.name,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )

                                    // ),

                                    ),
                              );
                            }),
                      ),
                      const SizedBox(height: 15),
                      ListView.builder(
                          itemCount: snapshot.data!.dishes.length,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var dishes = snapshot.data!.dishes[index];
                            return Column(
                              children: [
                                Visibility(
                                    visible: index == 0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Recommended",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  backgroundColor:
                                                      Colors.black),
                                              onPressed: () {},
                                              child: const Text("Menu")),
                                        )
                                      ],
                                    )),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        CupertinoPageRoute(
                                            builder: (context) => SecondScreen(
                                                foodId: dishes.id.toString(),
                                                rating:
                                                    dishes.rating.toString(),
                                                description:
                                                    dishes.description)));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  dishes.name,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(width: 5),
                                                Image.asset(
                                                  'assets/image/dot.png',
                                                  height: 15,
                                                  fit: BoxFit.cover,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 15),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: const Color(
                                                          0xff51C452)),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        dishes.rating
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Image.asset(
                                                        'assets/image/star.png',
                                                        height: 10,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 18),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Visibility(
                                                  visible: dishes
                                                          .equipments.length >=
                                                      2,
                                                  child: Column(
                                                    children: [
                                                      Image.asset(
                                                        'assets/image/f1.png',
                                                        height: 20,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      const SizedBox(height: 6),
                                                      const Text(
                                                        "Refrigerator",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Visibility(
                                                  visible: dishes
                                                      .equipments.isNotEmpty,
                                                  child: Column(
                                                    children: [
                                                      Image.asset(
                                                        'assets/image/f1.png',
                                                        height: 20,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      const SizedBox(height: 6),
                                                      Text(
                                                        dishes.equipments
                                                                    .length >
                                                                1
                                                            ? dishes
                                                                .equipments[1]
                                                            : dishes
                                                                .equipments[0],
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Container(
                                                  height: 25,
                                                  width: 1,
                                                  color: Colors.grey,
                                                ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Ingredients",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Row(
                                                      children: const [
                                                        Text(
                                                          "View list  ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xffFF941A)),
                                                        ),
                                                        Icon(
                                                            Icons
                                                                .arrow_forward_ios_sharp,
                                                            size: 10,
                                                            color: Color(
                                                                0xffFF941A))
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  170,
                                              child: Text(
                                                dishes.description,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 150,
                                          width: 131,
                                          child: Stack(
                                            // alignment: Alignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10),
                                                  height: 110,
                                                  // width: 120,
                                                  decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              dishes.image)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10),
                                                  height: 30,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xffFF941A)),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            blurRadius: 2)
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Text(
                                                        "Add            ",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffFF941A)),
                                                      ),
                                                      Icon(
                                                        Icons.add,
                                                        color:
                                                            Color(0xffFF941A),
                                                        size: 10,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                      const SizedBox(height: 100)
                    ]),
                Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 22),
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(children: [
                            Image.asset(
                              'assets/image/food.png',
                              height: 22,
                            ),
                            const Text("      3 food items selected",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500))
                          ]),
                          const Icon(Icons.arrow_forward, color: Colors.white)
                        ]))
              ]);
            }
          }),
    );
  }

  Future<GetDishesProduct> getDishesApiData() async {
    GetDishesProduct data;
    http.Response response = await http.get(ApiUrl.homeUrl);
    final jsonString = response.body;
    final jsonMap = jsonDecode(jsonString);
    data = GetDishesProduct.fromJson(jsonMap);
    return data;
  }
}
