import 'dart:convert';

import 'package:cinemagicx/raju.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReviewPagePopup extends StatefulWidget {
  String id;

  ReviewPagePopup({super.key, required this.id});

  @override
  _ReviewPagePopupState createState() => _ReviewPagePopupState();
}

class _ReviewPagePopupState extends State<ReviewPagePopup> {
  double _rating = 0.0;

  bool progrs = false;

  TextEditingController revtextctl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 16, 1, 23),
      title: Text("Write a Review"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Rate this Video :"),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.star,
                    color: _rating >= 1 ? Colors.orange : Colors.grey),
                onPressed: () => _setRating(1),
              ),
              IconButton(
                icon: Icon(Icons.star,
                    color: _rating >= 2 ? Colors.orange : Colors.grey),
                onPressed: () => _setRating(2),
              ),
              IconButton(
                icon: Icon(Icons.star,
                    color: _rating >= 3 ? Colors.orange : Colors.grey),
                onPressed: () => _setRating(3),
              ),
              IconButton(
                icon: Icon(Icons.star,
                    color: _rating >= 4 ? Colors.orange : Colors.grey),
                onPressed: () => _setRating(4),
              ),
              IconButton(
                icon: Icon(Icons.star,
                    color: _rating >= 5 ? Colors.orange : Colors.grey),
                onPressed: () => _setRating(5),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text("Write your review:"),
          SizedBox(height: 2),
          TextFormField(
            controller: revtextctl,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Enter your review here",
              hintStyle:
                  TextStyle(color: const Color.fromARGB(255, 65, 61, 61)),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilledButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 28, 2, 67))),
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              FilledButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 2, 44, 5)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)))),
                  onPressed: () async {
                    setState(() {
                      progrs = true;
                    });

                    final hpg = {
                      "rev": revtextctl.text,
                      "star": _rating,
                      "id": widget.id
                    };

                    print(jsonEncode(hpg));
                    try {
                      var response = await http.post(
                          Uri.parse('$backendurl/revx'),
                          headers: {"Content-Type": "application/json"},
                          body: jsonEncode(hpg));

                      setState(() {
                        Navigator.pop(context);
                      });
                    } catch (e) {
                      Navigator.pop(context);

                      print(e);
                    }

                    // Submit review with _rating and review text
                  },
                  child: progrs ? Text("Wait....!") : Text("Submit"))
            ],
          )
        ],
      ),
    );
  }

  void _setRating(double rating) {
    setState(() {
      _rating = rating;
    });
  }
}
