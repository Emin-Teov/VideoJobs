import 'package:flutter/material.dart';
import 'package:video_list/models/offer_model.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/offer_item.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<OfferModel>> fetchOffers(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://emin-teov.github.io/api/json/offers.json'));

  return compute(parseOffers, response.body);
}

List<OfferModel> parseOffers(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed.map<OfferModel>((json) => OfferModel.fromJson(json)).toList();
}

class OfferItems extends StatefulWidget {
  const OfferItems({super.key});

  @override
  State<OfferItems> createState() => _OfferItemsState();
}

class _OfferItemsState extends State<OfferItems> {
  late Future<List<OfferModel>> futureOffers;

  @override
  void initState() {
    super.initState();
    futureOffers = fetchOffers(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<OfferModel>>(
        future: futureOffers,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.error),
                  GetTextField(
                    text: "An error has occurred!",
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(25),
                    child: OfferItem(
                      id: snapshot.data![index].id,
                      tittle: snapshot.data![index].title,
                      employer_id: snapshot.data![index].employer_id,
                      employer: snapshot.data![index].ceo,
                      url: snapshot.data![index].url,
                      description: snapshot.data![index].description,
                      data: snapshot.data!.sublist(index, snapshot.data!.length),
                    ),
                  );
                }
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
