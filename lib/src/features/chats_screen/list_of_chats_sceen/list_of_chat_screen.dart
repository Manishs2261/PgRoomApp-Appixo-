import 'package:flutter/material.dart';

class ListOfChatScreen extends StatefulWidget {
  const ListOfChatScreen({super.key});

  @override
  State<ListOfChatScreen> createState() => _ListOfChatScreenState();
}

class _ListOfChatScreenState extends State<ListOfChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
        actions: [
          PopupMenuButton<String>(
              position: PopupMenuPosition.under,
              color: Colors.white,
              icon: const Icon(Icons.more_vert),
              onSelected: (String result) {

                _deleteAllChats(context);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: '1',
                  child: Row(
                    children: [
                      Icon(Icons.delete,color: Colors.red,),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Delete all chats')
                    ],
                  ),
                ),

              ])
        ],
      ),
      body: Column(
        children: [

          Container(
            color: Colors.white,
            child: ListTile(

              leading: CircleAvatar(
                backgroundImage: const NetworkImage('https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',),
                backgroundColor: Colors.blue.shade50,
                  child: const Icon(Icons.person)
              ),
              title: const Text('Manish sahu'),
              subtitle: const Text('jolly mess'),

            ),
          )

        ],
      ),
    );
  }

  void _deleteAllChats(BuildContext context) {
    // Show a confirmation dialog before deleting all chats
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete All Chats"),
          content: const Text("Are you sure you want to delete all chats?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                // Add your logic to delete all chats here
                Navigator.of(context).pop(); // Close the dialog after deleting
              },
            ),
          ],
        );
      },
    );
  }
}
