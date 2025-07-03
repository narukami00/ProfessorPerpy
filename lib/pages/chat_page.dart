import 'package:flutter/material.dart';
import 'package:perp_clone/theme/colors.dart';
import 'package:perp_clone/widgets/answer_seaction.dart';
import 'package:perp_clone/widgets/side_bar.dart';
import 'package:perp_clone/widgets/sources_section.dart';

class ChatPage extends StatelessWidget {
  final String question;
  const ChatPage({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              SideBar(),
              const SizedBox(width: 100),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 34),
                        SourcesSection(),
                        const SizedBox(width: 24),
                        AnswerSection(),
                      ],
                    ),
                  ),
                ),
              ),
              Placeholder(strokeWidth: 0, color: AppColors.background),
            ],
          ),
          Positioned(
            bottom: 32,
            right: 32,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              backgroundColor: AppColors.proButton,
              tooltip: "Back to Home",
              elevation: 4,
              child: Icon(Icons.home, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
