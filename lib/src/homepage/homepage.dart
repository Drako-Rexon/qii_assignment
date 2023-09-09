import 'package:flutter/material.dart';
import 'package:qii_assignment/helper/api_calls.dart';
import 'package:qii_assignment/helper/auth_service.dart';
import 'package:qii_assignment/model/news_model.dart';
import 'package:qii_assignment/utils/colors.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<News> response;

  @override
  void initState() {
    super.initState();
    getResponse();
  }

  getResponse() async {
    response = Apicalls.getNews().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          'Search in feed',
          style: TextStyle(
            color: blueColor,
          ),
        ),
        leading: const Icon(
          Icons.search,
          color: blueColor,
        ),
        actions: [
          IconButton(
            onPressed: () {
              AuthService().signOut();
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: blueColor,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => getResponse(),
        child: FutureBuilder<News>(
            future: response,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      !Apicalls.checkConnectivity()
                          ? Text("Using Local Storage")
                          : Text(''),
                      const SizedBox(height: 20),
                      ...List.generate(
                        snapshot.data!.articles.length,
                        (index) => Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                  color: blackColor.withAlpha(150),
                                  offset: const Offset(1, 1),
                                  blurRadius: 4,
                                  spreadRadius: 1)
                            ],
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 12,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot
                                          .data!.articles[index].source.name,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: greyColor, fontSize: 12),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      snapshot.data!.articles[index].title,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        color: blueColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      snapshot
                                          .data!.articles[index].description,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: blueColor, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(flex: 1, child: Container()),
                              Expanded(
                                flex: 7,
                                child: Container(
                                  margin: const EdgeInsets.only(),
                                  child: Image.network(
                                    snapshot.data!.articles[index].urlToImage,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else if (loadingProgress
                                              .cumulativeBytesLoaded ==
                                          loadingProgress.expectedTotalBytes) {
                                        return child;
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      return Image.asset(
                                          'assets/images/no_image.png');
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
