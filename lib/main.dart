import 'package:flutter/material.dart';
import '../services/openai/chat_service.dart';

void main() {
  runApp(MaterialApp(
    home: const OpenAIEntryScreen(),
  ));
}

class OpenAIEntryScreen extends StatefulWidget {
  const OpenAIEntryScreen({super.key});

  @override
  State<OpenAIEntryScreen> createState() => _OpenAIEntryScreenState();
}

class _OpenAIEntryScreenState extends State<OpenAIEntryScreen> {
  TextEditingController promptController = TextEditingController();
  String? response;
  bool isLoading = false; // Added a boolean to track loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: promptController,
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: "Prompt",
                hintText: "Enter your prompt here",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              response ?? "",
              style: TextStyle(color: Colors.grey.shade800),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
            ),
            onPressed: () async {
              setState(() {
                isLoading = true; // Show loading indicator
              });

              response = await ChatService().request(promptController.text);

              setState(() {
                isLoading =
                    false; // Hide loading indicator after receiving response
              });
            },
            child: const Text(
              "Submit",
              style: TextStyle(color: Colors.white),
            ),
          ),
          if (isLoading)
            CircularProgressIndicator(), // Show loading indicator when isLoading is true
        ],
      ),
    );
  }
}
