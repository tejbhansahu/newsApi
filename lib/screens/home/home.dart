import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapi/common/utils/colors.dart';
import 'package:newsapi/common/widgets/appBar.dart';
import 'package:newsapi/common/widgets/emptySheet.dart';
import 'package:newsapi/common/widgets/newsCard.dart';
import 'package:newsapi/common/widgets/sourcesWidget.dart';
import 'package:newsapi/provider/homeProvider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      fetchNews();
    });
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      fetchNews();
    }
  }

  fetchNews() async {
    await Provider.of<HomeProvider>(context, listen: false).fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBarMethod.appBarMethod(context: context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => emptySheet(context,
            statefulWidget: Sources(), height: 500, cornerRadius: 5),
        child: const Icon(Icons.filter_alt_rounded),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Column(
          children: [
            searchWidget(),
            topHeadline(),
            newsList(size),
          ],
        ),
      ),
    );
  }

  newsList(Size size) {
    return Expanded(
      child: Consumer<HomeProvider>(builder: (context, value, child) {
        if (value.isArticlesLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              itemCount: value.articles.length,
              controller: _controller,
              itemBuilder: (context, index) {
                var article = value.articles[index];
                if (index == value.articles.length - 1) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return newsCardWidget(context, size: size, article: article);
              });
        }
      }),
    );
  }

  searchWidget() {
    return TextFormField(
      controller: searchController,
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 15,
      ),
      autofocus: false,
      onFieldSubmitted: (value) {
        Provider.of<HomeProvider>(context, listen: false)
            .clearArticles();
        Provider.of<HomeProvider>(context, listen: false)
            .fetchNews(searchQuery: value);
        setState(() {});
      },
      cursorColor: Colors.black,
      decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.blueGrey.withOpacity(0.15),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13.0, horizontal: 15),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          hintText: "Search news, topics...",
          hintStyle: const TextStyle(
              fontFamily: "PoppinsLight", fontSize: 13.0, color: Colors.grey),
          suffixIcon: IconButton(
              onPressed: () {
                searchController.clear();
                Provider.of<HomeProvider>(context, listen: false)
                    .clearArticles();
                Provider.of<HomeProvider>(context, listen: false).fetchNews();
                setState(() {});
              },
              icon: searchController.text.isEmpty
                  ? Icon(CupertinoIcons.search)
                  : Icon(
                      CupertinoIcons.clear,
                      color: primaryColor,
                    ))),
    );
  }

  topHeadline() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 20),
      child: Row(
        children: [
          const Text(
            "Top Headlines",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Sort: ",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
              Consumer<HomeProvider>(builder: (context, value, child) {
                return DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: value.defaultFilter,
                    elevation: 1,
                    isDense: true,
                    iconEnabledColor: Colors.black87,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    items: value.timeFilters.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (filter) {
                      value.changeFilter(filter: filter.toString());
                    },
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
