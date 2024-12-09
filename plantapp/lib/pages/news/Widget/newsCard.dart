import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantapp/pages/models/News.dart'; // Import Article model
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
class NewsCard extends StatelessWidget {
  final Article article;

  // Nhận vào bài viết Article để hiển thị
  const NewsCard({Key? key, required this.article}) : super(key: key);

  void _launchURL(String url) async {
    final Uri _url = Uri.parse(url); // Chuyển đổi String thành Uri
    print("Attempting to launch URL: $_url"); // Debug: In URL trước khi mở
    if (await canLaunchUrl(_url)) {
      print("xin chao");
      await launchUrl(_url); // Mở URL
    } else {
      print('Could not launch $url'); // Thông báo nếu không mở được URL
    }
  }

  @override
  Widget build(BuildContext context) {
    // Kiểm tra nếu URL hình ảnh không có giá trị, sử dụng một hình ảnh mặc định
    String imageUrl = article.urlToImage ?? 'https://via.placeholder.com/150';
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: InkWell(
        onTap: () {
          // Mở URL khi người dùng nhấn vào
          if (article.url != null && article.url!.isNotEmpty) {
            _launchURL(article.url!);  // Mở link trong trình duyệt
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh đại diện (nếu có)
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(imageUrl, width: double.infinity, height: 180, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề bài viết
                  Text(
                    article.title ?? 'No Title',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Mô tả bài viết
                  Text(
                    article.description ?? 'No description available',
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  // Thời gian đăng bài
                  Text(
                    article.getDateOnly(),
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}