import 'package:flutter/material.dart';
import 'package:news_app/global.dart' as global;
import 'package:news_app/view/news_page/news_page.dart';
import 'package:country_code_picker/country_code_picker.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 80,
                ),
                const Text(
                  "News Category",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                CountryCodePicker(
                  flagDecoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white,
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignOutside),
                      borderRadius: BorderRadius.circular(20)),
                  onChanged: (element) => {
                    setState(() {
                      global.country = element.code.toString().toLowerCase();
                    })
                  },
                  initialSelection: global.country,
                  hideMainText: true,
                  showCountryOnly: true,
                  showOnlyCountryWhenClosed: true,
                ),
              ],
            ),
          ),
        ],
        backgroundColor: const Color(0xFF1F4690),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: global.newsCategories.length,
            itemBuilder: (context, index) {
              return btnNews(context, global.newsCategories[index]);
            },
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            )),
      ),
    );
  }
}

Widget btnNews(BuildContext context, String? category) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        width: 80,
        height: 80,
        child: TextButton(
          child: const Icon(
            size: 50,
            Icons.book,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        NewsPage(newCategory: category!)));
          },
        ),
      ),
      Text(category!),
    ],
  );
}
