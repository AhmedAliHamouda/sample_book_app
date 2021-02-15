import 'package:books_app/helpers/db_helper.dart';
import 'package:books_app/models/book.dart';
import 'package:flutter/material.dart';

class Books extends ChangeNotifier {
  List<Book> _booksItems = [];

  List<Book> get booksItems {
    return [..._booksItems];
  }

  Future<void> fetchData() async {
    final dataList = await DBHelper().getData('books_data');
    _booksItems = dataList
        .map(
          (bookItem) => Book(
            id: bookItem['id'],
            imageBook: bookItem['image'],
            nameBook: bookItem['name'],
            numberOfVersion: bookItem['numbers'],
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> updateData({int indexBook}) async {
    _booksItems[indexBook].numberOfVersion--;
    notifyListeners();

    await DBHelper.update(
      table: 'books_data',
      values: {
        'id':_booksItems[indexBook].id,
        'name':_booksItems[indexBook].nameBook,
        'image':_booksItems[indexBook].imageBook,
        'numbers':_booksItems[indexBook].numberOfVersion,
      },
      bookId: _booksItems[indexBook].id,
    );
  }
}
