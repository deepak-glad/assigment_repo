import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:testproject/controller/constant.dart';
import 'package:testproject/model/details_model.dart';

class SecondScreen extends StatefulWidget {
  final String foodId;
  final String rating;
  final String description;
  const SecondScreen(
      {required this.foodId,
      required this.rating,
      required this.description,
      super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late Future<DetailModel> _future;
  bool _isVeg = false;
  bool _isSpice = false;

  @override
  void initState() {
    _future = _getDetailsApiData();
    super.initState();
  }

  Widget _commonWidget(List<Spice> data) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          var newData = data[index];
          return Padding(
            padding: const EdgeInsets.all(6),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(newData.name,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.normal)),
                  Text(newData.quantity,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.normal)),
                ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: FutureBuilder<DetailModel>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                var data = snapshot.data;
                return SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        const CircleAvatar(
                            backgroundColor: Color.fromRGBO(255, 249, 242, 1),
                            radius: 102),
                        Stack(alignment: Alignment.topRight, children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            Text(data!.name,
                                                style: const TextStyle(
                                                    fontSize: 23,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(width: 10),
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      const Color(0xff51C452)),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    widget.rating,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Image.asset(
                                                    'assets/image/star.png',
                                                    height: 10,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  10,
                                              child: Text(
                                                widget.description,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        163, 163, 163, 1),
                                                    height: 1.5,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )),
                                          const SizedBox(height: 28),
                                          Row(children: [
                                            Image.asset(
                                                'assets/image/watch.png',
                                                height: 15),
                                            const SizedBox(width: 6),
                                            Text(
                                              snapshot.data!.timeToPrepare
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ])
                                        ])),
                                const Divider(
                                    color: Color.fromRGBO(242, 242, 242, 1),
                                    thickness: 8),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Ingredients',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'For 2 people',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xff8A8A8A)),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Divider(
                                              color: Color.fromRGBO(
                                                  242, 242, 242, 1),
                                              thickness: 2),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Row(children: [
                                            const Text("Vegetables (05)",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _isVeg = !_isVeg;
                                                  });
                                                },
                                                icon: Icon(
                                                    _isVeg
                                                        ? Icons.arrow_drop_up
                                                        : Icons.arrow_drop_down,
                                                    size: 30))
                                          ]),
                                        ),
                                        if (!_isVeg) const SizedBox(height: 10),
                                        if (!_isVeg)
                                          _commonWidget(
                                              data.ingredients.vegetables),
                                        SizedBox(
                                          width: 150,
                                          child: Row(children: [
                                            const Text("Spices (10)",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _isSpice = !_isSpice;
                                                  });
                                                },
                                                icon: Icon(
                                                    _isSpice
                                                        ? Icons.arrow_drop_up
                                                        : Icons.arrow_drop_down,
                                                    size: 30))
                                          ]),
                                        ),
                                        const SizedBox(height: 10),
                                        if (!_isSpice)
                                          _commonWidget(
                                              data.ingredients.spices),
                                        const SizedBox(height: 20),
                                        const Text('Appliances',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              100,
                                          height: 120,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: data.ingredients
                                                  .appliances.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  width: 72,
                                                  height: 95,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffF5F5F5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  margin:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        if (data
                                                                .ingredients
                                                                .appliances[
                                                                    index]
                                                                .image ==
                                                            '')
                                                          Image.asset(
                                                              'assets/image/freeze.png'),
                                                        Text(
                                                            data
                                                                .ingredients
                                                                .appliances[
                                                                    index]
                                                                .name,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            )),
                                                      ]),
                                                );
                                              }),
                                        )
                                      ]),
                                )
                              ]),
                          Image.asset('assets/image/vegs.png', height: 180)
                        ])
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<DetailModel> _getDetailsApiData() async {
    DetailModel data;
    http.Response response =
        await http.get(Uri.parse('${ApiUrl.detailsUrl}${widget.foodId}'));
    final jsonString = response.body;
    final jsonMap = jsonDecode(jsonString);
    print(jsonMap);
    data = DetailModel.fromJson(jsonMap);
    return data;
  }
}
