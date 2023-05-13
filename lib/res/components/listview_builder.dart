
import 'package:flutter/material.dart';

import '../../model/user_details_response.dart';


class AppListViewBuilder extends StatelessWidget {
  const AppListViewBuilder({super.key, required this.itemcount, required this.titletext, this.ontap, required this.trailingtext, this.userdata});
  final int itemcount;
  final String titletext;
  final String trailingtext;
  final void Function()? ontap;
  final Dashboard? userdata;
  //final int index;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemcount,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: ontap,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black87, width: 1),
            ),
            color: Colors.transparent,
            child: ListTile(
              title: Text(
                titletext,
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text(
                trailingtext,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
