import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:news_app/view/news_page/news_detail_page.dart';
import 'package:news_app/global.dart' as global;

class NewsPage extends StatefulWidget {
  const NewsPage({super.key, required this.newCategory});
  final String newCategory;
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<NewsResponse> newsDetail;
  TextEditingController searchController = TextEditingController();
  late String newsCategory = widget.newCategory.toLowerCase();
  late String urlNews =
      "https://newsapi.org/v2/top-headlines?country=${global.country}&category=$newsCategory&apiKey=${global.apiKey}";
  Future<NewsResponse> fetchAPI(String url) async {
    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      return NewsResponse.fromJson(jsonDecode(res.body));
    } else {
      return throw Exception("failed to load news" + res.body);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      global.country;
      newsDetail = fetchAPI(urlNews);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 80,
                ),
                Text(
                  "${widget.newCategory} News",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
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
                      urlNews =
                          "https://newsapi.org/v2/top-headlines?country=${global.country}&category=$newsCategory&apiKey=${global.apiKey}";
                      newsDetail = fetchAPI(urlNews);
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SearchBar(
              leading: const Icon(Icons.search),
              controller: searchController,
              hintText: "Search News..",
              onChanged: (value) {
                setState(() {
                  urlNews =
                      "https://newsapi.org/v2/top-headlines?q=${searchController.text}&country=${global.country}&category=$newsCategory&apiKey=${global.apiKey}";
                  newsDetail = fetchAPI(urlNews);
                });
              },
            ),
            FutureBuilder<NewsResponse>(
                future: newsDetail,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    late List<Article> newsArticle = snapshot.data!.articles;
                    return Container(
                      height: 700,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: newsArticle.length,
                        itemBuilder: (context, index) {
                          String authorCheck() {
                            late String author;
                            if (newsArticle[index]
                                    .author
                                    .toString()
                                    .contains(RegExp('/')) ==
                                true) {
                              author = "-";
                              return author;
                            } else {
                              author = newsArticle[index].author.toString();
                              return author;
                            }
                          }

                          return Card(
                              color: Colors.grey[50],
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            newsArticle[index].title.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            authorCheck(),
                                            style: const TextStyle(
                                                color: Colors.blue),
                                          ),
                                          Text(newsArticle[index]
                                              .publishedAt
                                              .toString()),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        ArticleDetails(
                                                          articleURL:
                                                              newsArticle[index]
                                                                  .url
                                                                  .toString(),
                                                        )));
                                      },
                                    ),
                                  ],
                                ),
                              ));
                        },
                        scrollDirection: Axis.vertical,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Column(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text('Error: ${snapshot.error}'),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      heightFactor: 5,
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
