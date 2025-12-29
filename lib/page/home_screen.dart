import 'package:flutter/material.dart';
import 'package:socialy/widgets/search_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0,
          title: const Text(
            'Socialy',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
              color: Colors.white,
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
            tabs: [
              Tab(text: "Chats"),
              Tab(text: "Requests"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text("No Chats Yet")),
            Center(child: Text("No Friend Requests")),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const SearchUser(),
            );
          },
          backgroundColor: Colors.teal,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
