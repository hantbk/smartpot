import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:plantapp/pages/news/Widget/newsCard.dart';
import 'package:plantapp/services/NewsService.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantapp/pages/models/News.dart';  // Import model Article và NewsApiResponse

class HomeNewsPage extends StatefulWidget {
  const HomeNewsPage({super.key});

  @override
  _HomeNewsPageState createState() => _HomeNewsPageState();
}

class _HomeNewsPageState extends State<HomeNewsPage> {
  bool isLoading = true;  // Biến trạng thái để hiển thị loading
  String? errorMessage;   // Lưu thông báo lỗi (nếu có)
  List<Article> newsArticles = []; // Lưu danh sách bài viết tin tức

  @override
  void initState() {
    super.initState();
    _fetchNewsData();  // Lấy tin tức từ API khi trang được tải
  }

  // Hàm lấy dữ liệu tin tức
  Future<void> _fetchNewsData() async {
    try {
      String category = "";  // Từ khóa tìm kiếm, có thể là "plants", "horticulture", v.v.
      List<Article> data = await NewsService().fetchNewsList(category: category);

      if (data.isNotEmpty) {
        // Cập nhật dữ liệu vào newsArticles
        setState(() {
          isLoading = false;  // Đổi trạng thái khi nhận được dữ liệu
          newsArticles = data;  // Lưu danh sách bài viết vào newsArticles
        });
      } else {
        // Nếu không có bài viết, thông báo lỗi
        setState(() {
          isLoading = false;
          errorMessage = 'No data found.';
        });
      }
    } catch (e) {
      // Xử lý lỗi khi gọi API
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load news: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "News",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 25),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromRGBO(161, 207, 107, 1),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Hiển thị loading khi đang tải
          : errorMessage != null
              ? Center(
                  child: Text(
                    errorMessage ?? 'An unknown error occurred',
                    style: GoogleFonts.poppins(fontSize: 18, color: Colors.red),
                  ),
                ) // Hiển thị thông báo lỗi nếu có
              : ListView.builder(
                  itemCount: newsArticles.length, // Đếm số lượng bài viết
                  itemBuilder: (context, index) {
                    var article = newsArticles[index]; // Lấy bài viết tại index
                    return NewsCard(article: article); // Tạo NewsCard cho mỗi bài viết
                  },
                ),
    );
  }
}
