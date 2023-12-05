import 'package:bidbazar/widgets/productView.dart';
import 'package:bidbazar/widgets/search.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        const SliverAppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: Text("Bidbazar"),
          expandedHeight: 200,
          pinned: true,
        )
      ],
      body: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
        // width: size.width * 1,
        // height: size.height * 1,
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Search(),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Icon(
                      Icons.grid_view,
                      color: Colors.amber[900],
                    ),
                  ),
                  Expanded(flex: 3, child: Container(child: Text("Filter"))),
                ],
              ),
            ),
            Expanded(flex: 7, child: productView())
          ],
        ),
      ),
    );
  }
}
