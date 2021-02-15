import 'package:books_app/providers/books_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  simpleDialog(Books books,int index){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            Column(
              children: [
                FlatButton(
                  onPressed:  books.booksItems[index].numberOfVersion==0 ? (){
                    Navigator.pop(context);
                  }:() {
                    books.updateData(indexBook: index);
                    Navigator.pop(context);
                  },
                  child: Text(
                    books.booksItems[index].numberOfVersion==0? 'Close': 'Borrow It',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  color: Colors.indigo,
                ),
              ],
            ),
          ],
          title: Text(
            books.booksItems[index].numberOfVersion==0
                ?'this book is Borrowed Out'
             :'Do you want to borrow this book?',
            textAlign: TextAlign.center,
          ),
        );
      },
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books App'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Provider.of<Books>(context, listen: false).fetchData(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Books>(
                builder: (context, books, index) {
                  if (books.booksItems.length <= 0) {
                    return Center(
                      child: Text('No Books'),
                    );
                  } else {
                    return GridView.builder(
                      padding: EdgeInsets.all(10.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemCount: books.booksItems.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                          )),
                          elevation: 5.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0),
                            ),
                            child: GridTile(
                              child: GestureDetector(
                                onTap: () {
                                  simpleDialog(books, index);
                                },
                                child: Image.asset(
                                  books.booksItems[index].imageBook,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              footer: GridTileBar(
                                backgroundColor: Colors.black87,
                                title: Text(books.booksItems[index].nameBook),
                                trailing: Text(
                                  '${books.booksItems[index].numberOfVersion}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
      ),
    );
  }
}
