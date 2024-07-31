import 'package:flutter/material.dart';
import 'service/api_service.dart';
import 'service/post_model.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final HttpService _httpService = HttpService();
  final TextEditingController _controller = TextEditingController();
  List<Message> _messages = [];

  void _sendMessage() async {
    if (_controller.text.isEmpty) {
      return;
    }

    final userMessage = _controller.text;

    setState(() {
      _messages.add(Message(content: userMessage, role: 'user'));
    });

    _controller.clear();

    try {
      Post response = await _httpService.getPost(userMessage);
      print('API Response Messages: ${response.messages}'); // Debug log

      setState(() {
        _messages.addAll(response.messages);
      });
    } catch (e) {
      print('Error: $e'); // Debug log
      setState(() {
        _messages.add(Message(content: 'Error: $e', role: 'system'));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding around the title
          child: Text(
            'Melin AI',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Make the text bold
              fontSize: 18.0, // Reduce the font size
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30), // Increased padding
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/Done.jpg'), // Corrected image path
              radius: 20.0, // Increased radius for a larger profile image
            ),
          ),
        ],
        // backgroundColor: Colors.blueAccent, // Optional: Set AppBar color
      ),
      body: Container(
        // color: Color(0xFFE5E5EA), // Background color for the chat screen
        child: Column(
          children: <Widget>[
            SizedBox(height: 16.0), // Space between AppBar and chat messages
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0), // Centering the ListView
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isUser = message.role == 'user';
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start, // Align messages to the start
                            mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                            children: <Widget>[
                              if (!isUser) // Show AI image only if not a user message
                                CircleAvatar(
                                  backgroundImage: AssetImage('assets/Done.jpg'), // Ensure the path is correct
                                  radius: 16.0, // Adjust radius if needed
                                  backgroundColor: Colors.transparent,
                                ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Align(
                                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: isUser
                                          ? Colors.blueAccent
                                          : Color(0xFFE5E5EA),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      message.content,
                                      style: TextStyle(
                                        color: isUser
                                            ? Colors.white
                                            : Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (isUser) // Show user image only if it is a user message
                                SizedBox(width: 8.0),
                              if (isUser)
                                CircleAvatar(
                                  backgroundImage: AssetImage('assets/jono.png'), // Ensure the path is correct
                                  radius: 16.0, // Adjust radius if needed
                                  backgroundColor: Colors.transparent,
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.0), // Space between chat messages
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        hintStyle: TextStyle(color: Colors.grey[600]), // Custom hint text color
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0), // Add padding inside the input
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0), // Space between text field and send button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.send, color: Colors.white),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
