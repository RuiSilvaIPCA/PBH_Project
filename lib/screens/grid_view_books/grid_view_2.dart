import 'package:flutter/material.dart';
import 'package:pbh_project/controllers/book_filter_category_utils.dart';
import 'package:pbh_project/screens/book_profile_page/book_list_card.dart';

import '../../controllers/show_profile_controller.dart';
import '../../models/books_out.dart';
import '../../models/user.dart';

class MyGridViewCopy2 extends StatefulWidget {
  final int categoryId;
  const MyGridViewCopy2({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<MyGridViewCopy2> createState() => _MyGridViewCopy2State();
}

class _MyGridViewCopy2State extends State<MyGridViewCopy2> {
  ShowProfileController bookController = ShowProfileController();
  ShowProfileController writterController = ShowProfileController();

  List<BooksOut> books = [];
  List<BooksOut> filteredBooks = [];
  User? user;

  @override
  void initState() {
    super.initState();
    bookController.getAllBooks().then((result2) {
      setState(() {
        books = result2;
        filteredBooks = BookFilterByCategory.filterBooksByCategory(
          books,
          widget.categoryId,
        );
      });
    });
  }

  @override
  void dispose() {
    bookController;
    writterController;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          childAspectRatio: 1.11,
        ),
        primary: false,
        shrinkWrap: true,
        itemCount: filteredBooks.length, // Replace with actual genre count
        itemBuilder: (context, index) {
          final book = filteredBooks[index];

          writterController.getWritterByBook(book.bookId).then((value) {
            if (mounted) {
              setState(() {
                user = value;
              });
            }
          });
          return BookListCard(book: book, user: user);
        },
      ),
    );
  }
}
