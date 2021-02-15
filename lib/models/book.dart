import 'dart:io';

import 'package:flutter/foundation.dart';

class Book {
  final String id;
  final String imageBook;
  final String nameBook;
   int numberOfVersion;

  Book({
    @required this.id,
    @required this.imageBook,
    @required this.nameBook,
    @required this.numberOfVersion,
  });
}
