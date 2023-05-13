import 'package:flutter/material.dart';

class ReusableSearchbar extends StatelessWidget {
  const ReusableSearchbar({
    super.key,
    required this.topPadding,
    required this.screenWidth,
    required this.screenHeight,
    required this.bgColor,
    required this.searchIcon,
    this.onPressed, 
    this.controller, 
    this.onChanged, this.hinttextcolor, this.hinttext, this.keyboard,
  });
  final double topPadding;
  final double screenWidth;
  final double screenHeight;
  final Color bgColor;
  final Color? hinttextcolor;
final String? hinttext;
  final controller;
  final TextInputType? keyboard;

  final Function()? onPressed;
  final Function(String)? onChanged;

  final Icon searchIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * screenWidth,
            height: MediaQuery.of(context).size.height * screenHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: SizedBox(
                      height: 60.0,
                      child: Center(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: keyboard,
                          maxLength: 12,
                          
                          onChanged: onChanged,
                          controller: controller,
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                            ),
                            hintText: hinttext,
                            hintStyle:
                                TextStyle(color: hinttextcolor, fontSize: 12.0, ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: onPressed,
                    child: Container(
                      child: Icon(Icons.search,
                      color: Colors.white,
                        
                      ),
                    ))/* IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      onPressed:
                          onPressed,
                      ), 270822556445*/
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/* class CustomSearchDelegate extends SearchDelegate {
  List<String> searchResults = ["12", "23", "34", "56"];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (() {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
            //
          }),
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (() {
          close(context, null);
        }),
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
          child: TextWidget(
        text: query,
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
        textcolor: Colors.green,
      )),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchquery = searchResults.where((element) {
      final res = element.toLowerCase();
      final input = query.toLowerCase();
      return res.contains(input);
    }).toList();
    return ListView.builder(
        itemCount: matchquery.length,
        itemBuilder: ((context, index) {
          var result = matchquery[index];
          return ListTile(
            title: Text("${result}"),
            onTap: (() {
              query = result;
              showResults(context);
            }),
          );
        }));
  }
}
 */