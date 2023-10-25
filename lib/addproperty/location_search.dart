import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_my_appartment/addproperty/places_autocomplete.dart';
import 'package:share_my_appartment/addproperty/places_autocomplete_util.dart';
import 'package:uuid/uuid.dart';

import '../constant/constants.dart';

class LocationSearchScreen extends StatefulWidget {
  final String title;
  final StreamSink<PlaceDetail> sink;

  const LocationSearchScreen({Key? key, required this.title, required this.sink}) : super(key: key);

  @override
  _LocationSearchScreenState createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  final _controller = TextEditingController();
  final sessionToken = const Uuid().v4();
  final provider = PlaceApiProvider(const Uuid().v4());
  List<Suggestion> suggestion = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() async {
      if (_controller.text.length > 1) {
        suggestion = await provider.fetchSuggestions(_controller.text);
      } else {
        suggestion.clear();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_rounded),
                  iconSize: 32,
                  padding: const EdgeInsets.only(left: 16, top: 8),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, top: 16, bottom: 4),
                  child: Text(
                    widget.title,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 18, top: 8, right: 18),
              padding: const EdgeInsets.only(
                  left: 12, right: 12),
              height: 48,
              decoration: BoxDecoration(
                color: light_gray,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.start,
                autocorrect: false,
                autofocus: true,
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: black,
                ),
                decoration: const InputDecoration(
                  hintText: "Search location",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 12,top: 8, bottom: 4),
                        child: Text(
                          (suggestion[index]).title,
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            color: black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left:12,top: 4, bottom: 8),
                        child: Text(
                          (suggestion[index]).description,
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            color: black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    final placeDetail = await provider.getPlaceDetailFromId(suggestion[index].placeId);
                    widget.sink.add(placeDetail);
                    Navigator.of(context).pop();
                  },
                ),
                itemCount: suggestion.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
