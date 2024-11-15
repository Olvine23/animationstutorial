import 'package:flutter/material.dart';
import 'cat_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CatApp extends StatefulWidget {
  @override
  _CatAppState createState() => _CatAppState();
}

class _CatAppState extends State<CatApp> {
  List<Map<String, dynamic>> _catData = [];
  final CatService _catService = CatService();
  bool _isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchCatImages(); // Initial fetch
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Fetch cat images
  void _fetchCatImages() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      final newCatData = await _catService.getCatImages();
      setState(() {
        _catData.addAll(newCatData);
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      print("Error fetching cat images: $e");
    }
  }

  // Infinite scroll listener
  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _fetchCatImages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Info List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cat Info List'),
        ),
        body: _catData.isEmpty && _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _catData.length + 1,
                        itemBuilder: (context, index) {
                          if (index == _catData.length) {
                            return _isLoading
                                ? Center(child: CircularProgressIndicator())
                                : SizedBox.shrink();
                          }

                          final cat = _catData[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15)),
                                  child: CachedNetworkImage(
                                    imageUrl: cat['url'],
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                ),
                                TweenAnimationBuilder(
                                  duration: Duration(milliseconds: 7000),
                                  tween: Tween<double>(begin: 0, end: 1),
                                  builder: (BuildContext context, double val,
                                      Widget? child) {
                                    return Opacity(opacity: val, child: child);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(cat['breed'] ?? 'Unknown',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                        SizedBox(height: 4),
                                        Text("Origin: ${cat['origin']}"),
                                        SizedBox(height: 4),
                                        Text(
                                            "Temperament: ${cat['temperament']}"),
                                        SizedBox(height: 4),
                                        Text(
                                            "Lifespan: ${cat['life_span']} years"),
                                        SizedBox(height: 4),
                                        // cat['description'] != null
                                        //     ? Text(cat['description'],
                                        //         style: TextStyle(fontSize: 12, color: Colors.grey[600]))
                                        //     : SizedBox.shrink(),
                                        // if (cat['wikipedia_url'] != null)
                                        //   GestureDetector(
                                        //     onTap: () async {

                                        //     },
                                        //     child: Text(
                                        //       "More on Wikipedia",
                                        //       style: TextStyle(color: Colors.blue, fontSize: 12),
                                        //     ),
                                        //   ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
