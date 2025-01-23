import 'package:flutter/material.dart';
import 'package:only_tix/presentation/misc/constants.dart';

Widget searchBar(BuildContext context) => Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 24 - 24 - 90,
          height: 50,
          margin: const EdgeInsets.only(left: 24, right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: brightCyan, width: 2),
          ),
          child: TextField(
            style: TextStyle(color: Colors.grey.shade800),
            decoration: const InputDecoration(
              hintText: 'Search movie',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              icon: Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ),
        SizedBox(
          width: 80,
          height: 50,
          child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: const Center(
                child: Icon(Icons.search, color: brightCyan),
              )),
        )
      ],
    );
