import 'package:flutter/material.dart';

class CourseBuilderScreen extends StatefulWidget {
  @override
  _CourseBuilderScreenState createState() => _CourseBuilderScreenState();
}

class _CourseBuilderScreenState extends State<CourseBuilderScreen> {
  List<Lecture> lectures = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Builder'),
      ),
      body: ListView(
        children: lectures.map((lecture) => LectureCard(lecture)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return LecturePopup(onLectureAdded: (title, description) {
                setState(() {
                  lectures.add(Lecture(title, description));
                });
                Navigator.pop(context);
              });
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Lecture {
  final String title;
  final String description;


  Lecture(this.title, this.description);
}

class LectureCard extends StatefulWidget {
  final Lecture lecture;

  LectureCard(this.lecture);

  LectureCardState createState() => LectureCardState();
}

class LectureCardState extends State<LectureCard> {

  List<Section> sections = [];
  List<Quiz> quizzes = [];

  void _addSection(String title, String content) {
    setState(() {
      sections.add(Section(title, content));
    });
  }

  void _addQuiz(String title, List<String> questions) {
    setState(() {
      quizzes.add(Quiz(title, questions));
    });
  }

  void _removeLecture() {
    // Implement the removal logic here
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(widget.lecture.title),
              subtitle: Text(widget.lecture.description),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add Section
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SectionPopup(onSectionAdded: _addSection);
                        },
                      );
                    },
                    child: Text('Add Section'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add Quiz
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return QuizPopup(onQuizAdded: _addQuiz);
                        },
                      );
                    },
                    child: Text('Add Quiz'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _removeLecture,
                    child: Text('Remove Lecture'),
                  ),
                ),
              ],
            ),
            // Display sections and quizzes here
      Column(
        children: [
          for (var section in sections)
            ListTile(
              title: Text('Section: ${section.title}'),
              subtitle: Text(section.content),
            ),
          for (var quiz in quizzes)
            ListTile(
              title: Text('Quiz: ${quiz.title}'),
              subtitle: Text('Questions: ${quiz.questions.join(", ")}'),
            ),
        ],
          ),
       ]
        ),
      ),
    );
  }
}

class LecturePopup extends StatelessWidget {
  final Function(String, String) onLectureAdded;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  LecturePopup({required this.onLectureAdded});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Lecture'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onLectureAdded(titleController.text, descriptionController.text);
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}

// Define the Section and Quiz classes as per your requirements

class Section {
  final String title;
  final String content;

  Section(this.title, this.content);
}

class Quiz {
  final String title;
  final List<String> questions;

  Quiz(this.title, this.questions);
}




class SectionPopup extends StatelessWidget {
  final Function(String, String) onSectionAdded;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  SectionPopup({required this.onSectionAdded});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Section'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: contentController,
            decoration: InputDecoration(labelText: 'Content'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onSectionAdded(titleController.text, contentController.text);
            Navigator.of(context).pop();
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}

class QuizPopup extends StatelessWidget {
  final Function(String, List<String>) onQuizAdded;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController questionsController = TextEditingController();

  QuizPopup({required this.onQuizAdded});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Quiz'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: questionsController,
            decoration: InputDecoration(labelText: 'Questions (comma-separated)'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final questions = questionsController.text.split(',');
            onQuizAdded(titleController.text, questions);
            Navigator.of(context).pop();

          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
