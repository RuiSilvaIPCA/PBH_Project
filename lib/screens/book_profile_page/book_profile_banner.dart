import 'package:flutter/material.dart';

import 'package:pbh_project/screens/donation_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../controllers/book_profile_controller.dart';
import '../../models/books_out.dart';
import '../../models/user.dart';
import '../../resources/strings.dart';
import '../../utils/app_styles.dart';
import 'book_info_card.dart';
import 'book_sinopse_card.dart';

class BookProfileBanner extends StatefulWidget {
  //variables
  User? user;
  BooksOut? book;
  BookProfileBanner({super.key, this.book, this.user});

  @override
  State<BookProfileBanner> createState() => _BookProfileBannerState();
}

class _BookProfileBannerState extends State<BookProfileBanner> {
  BookProfileController writterController = BookProfileController();
  BookProfileController bookController = BookProfileController();

  List<BooksOut> allBooks = [];
  BooksOut? book;
  User? user;
  @override
  void initState() {
    writterController.getWritterByBook(widget.book!.bookId).then((value) {
      user = value;
    });
    bookController.getAllBooks().then((value2) {
      allBooks = value2;
      book = BookProfileController.filterBookByBookId(
          allBooks, widget.book!.bookId);
    });
    super.initState();
  }

  @override
  void dispose() {
    bookController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: Stack(
            children: const [
              Image(image: AssetImage('assets/images/teste_book_1.png')),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (DonationScreen(
                            book: widget.book,
                            user: widget.user,
                          ))));
            },
            child: Container(
              width: 180,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: writterLogoColor,
                borderRadius: BorderRadius.all(Radius.circular(29)),
              ),
              child: const Text(
                Strings.kDonationSubmit,
                style: kTitle4,
              ),
            ),
          ),
        ),
        Stack(
          children: [
            Positioned(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                alignment: Alignment.topCenter,
                height: 400,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(29)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 33,
                      color: kshadowcolor,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: LinearPercentIndicator(
                          alignment: MainAxisAlignment.end,
                          lineHeight: 30,
                          percent: 0.9,
                          progressColor: writterLogoColor,
                          backgroundColor:
                              const Color.fromRGBO(230, 208, 190, 1),
                          barRadius: const Radius.circular(30),
                          center: const Text(
                            'Achievement: 50%',
                            style: kTitle1,
                          ),
                        ),
                      ),
                      BookInfoCard(
                        bookId: widget.book!.bookId,
                        rating: 2,
                        writterName: user?.name ?? 'Unknown Author',
                      ),
                      BookSinopseCard(
                          sinopse:
                              book?.description ?? 'No description available'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
