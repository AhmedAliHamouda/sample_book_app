import 'package:books_app/models/book.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sql.dart';
import 'package:sqflite/utils/utils.dart';

class DBHelper {

  List<Book> initDataBooks = [
    Book(
        id: '1',
        imageBook: 'images/CleanCode.jpg',
        nameBook: 'Clean Code',
        numberOfVersion: 4),
    Book(
        id: '2',
        imageBook: 'images/1919.jpg',
        nameBook: '1919',
        numberOfVersion: 2),
    Book(
        id: '3',
        imageBook: 'images/augmented_reality.jpg',
        nameBook: 'Augmented Reality',
        numberOfVersion: 6),
    Book(
        id: '4',
        imageBook: 'images/java-programming-book.png',
        nameBook: 'Java Programming',
        numberOfVersion: 3),
    Book(
        id: '5',
        imageBook: 'images/beginning-app-development-with-flutter.jpg',
        nameBook: 'Beginning with Flutter',
        numberOfVersion: 10),
    Book(
        id: '6',
        imageBook: 'images/ios.jpg',
        nameBook: 'SwiftUI Essentials',
        numberOfVersion: 7),
  ];

  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'books.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE books_data(id TEXT PRIMARY KEY,name TEXT,image TEXT,numbers INT)');
      },
      version: 1,
    );
  }


   Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    final count=firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM books_data'));
    if(count==0){
      await initDatabase();
      return db.query(table);
    }else {

      return db.query(table);
    }

  }

  Future<void> initDatabase() async {
    final db = await DBHelper.database();
    for (int i = 0; i < initDataBooks.length; i++) {
      db.insert(
        'books_data',
        {
          'id':initDataBooks[i].id,
          'name':initDataBooks[i].nameBook,
          'image':initDataBooks[i].imageBook,
          'numbers':initDataBooks[i].numberOfVersion,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<void> update({String table, Map<String, Object> values, String bookId}) async {
    final db = await DBHelper.database();
    db.update(
      table,
      values,
      where: "id=?",
      whereArgs: [bookId],
    );
  }


// static Future<void> insert({String table, Map<String, Object> data}) async {
//   final db = await DBHelper.database();
//   db.insert(
//     table,
//     data,
//     conflictAlgorithm: ConflictAlgorithm.replace,
//   );
// }

}
