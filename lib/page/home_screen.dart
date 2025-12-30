import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socialy/widgets/chat_tile.dart';
import 'package:socialy/widgets/friend_request_tile.dart';
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
            PopupMenuButton<String>(
              onSelected: (value) {
                // TODO: Handle menu selection
              },
              icon: const Icon(Icons.more_vert, color: Colors.white),
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'profile_settings',
                    child: Text('Profile Settings'),
                  ),
                ];
              },
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
            tabs: [
              Tab(text: "Chats"),
              Tab(text: "Requests"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: [
                ChatTile(
                  name: "Jane Doe",
                  message: "Hey! How are you?",
                  time: "10:30 AM",
                  onTap: () => context.push('/chat', extra: "Jane Doe"),
                ),
                ChatTile(
                  name: "John Smith",
                  message: "Let's meet tomorrow.",
                  time: "Yesterday",
                  onTap: () => context.push('/chat', extra: "John Smith"),
                ),
                ChatTile(
                  name: "Alex Johnson",
                  message: "Can you send the file?",
                  time: "Yesterday",
                  onTap: () => context.push('/chat', extra: "Alex Johnson"),
                ),
              ],
            ),
            ListView(
              children: [
                FriendRequestTile(
                  name: "Sarah Connor",
                  time: "1d",
                  onConfirm: () {}, // TODO: Implement Accept Logic
                  onDelete: () {}, // TODO: Implement Delete Logic
                ),
                FriendRequestTile(
                  name: "Kyle Reese",
                  time: "2w",
                  onConfirm: () {},
                  onDelete: () {},
                ),
                FriendRequestTile(
                  name: "Marcus Wright",
                  time: "5m",
                  onConfirm: () {},
                  onDelete: () {},
                ),
              ],
            ),
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
