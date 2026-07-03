import 'package:flutter/material.dart';

void main() {
  runApp(const MyDrawingApp());
}

class MyDrawingApp extends StatelessWidget {
  const MyDrawingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'قلمي الذكي',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.purpleAccent],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 12,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '✏️ قلمي الذكي ✏️',
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.purple),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'تطبيق تعليمي ذكي يفحص دقة كتابة الطفل للحروف والأرقام فورياً!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 35),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SelectionScreen()),
                        );
                      },
                      child: const Text(
                        'ابدأ التعلم الآن',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ماذا تريد أن تتعلم اليوم؟', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.purple,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DrawingScreen(isLetters: true)),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.amber, width: 4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit_note, size: 100, color: Colors.amber.shade900),
                    const SizedBox(height: 15),
                    Text(
                      'تعلم كتابة الحروف',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber.shade900),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DrawingScreen(isLetters: false)),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.blue, width: 4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.pin, size: 100, color: Colors.blue.shade900),
                    const SizedBox(height: 15),
                    Text(
                      'تعلم كتابة الأرقام',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawingScreen extends StatefulWidget {
  final bool isLetters;
  const DrawingScreen({super.key, required this.isLetters});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  // الحروف كاملة من أ إلى ي مع نقاط التتبع الذكية
  final List<Map<String, dynamic>> lettersList = [
    {'char': 'أ', 'arrow': Icons.arrow_downward, 'align': Alignment.topCenter, 'checkpoints': [Offset(0.5, 0.25), Offset(0.5, 0.5), Offset(0.5, 0.75)]},
    {'char': 'ب', 'arrow': Icons.arrow_back, 'align': Alignment.bottomRight, 'checkpoints': [Offset(0.8, 0.6), Offset(0.5, 0.65), Offset(0.2, 0.6)]},
    {'char': 'ت', 'arrow': Icons.arrow_back, 'align': Alignment.bottomRight, 'checkpoints': [Offset(0.8, 0.6), Offset(0.5, 0.65), Offset(0.2, 0.6)]},
    {'char': 'ث', 'arrow': Icons.arrow_back, 'align': Alignment.bottomRight, 'checkpoints': [Offset(0.8, 0.6), Offset(0.5, 0.65), Offset(0.2, 0.6)]},
    {'char': 'ج', 'arrow': Icons.reply, 'align': Alignment.topRight, 'checkpoints': [Offset(0.7, 0.3), Offset(0.5, 0.3), Offset(0.3, 0.5), Offset(0.5, 0.7)]},
    {'char': 'ح', 'arrow': Icons.reply, 'align': Alignment.topRight, 'checkpoints': [Offset(0.7, 0.3), Offset(0.5, 0.3), Offset(0.3, 0.5), Offset(0.5, 0.7)]},
    {'char': 'خ', 'arrow': Icons.reply, 'align': Alignment.topRight, 'checkpoints': [Offset(0.7, 0.3), Offset(0.5, 0.3), Offset(0.3, 0.5), Offset(0.5, 0.7)]},
    {'char': 'د', 'arrow': Icons.south_west, 'align': Alignment.topRight, 'checkpoints': [Offset(0.6, 0.4), Offset(0.4, 0.6), Offset(0.6, 0.6)]},
    {'char': 'ذ', 'arrow': Icons.south_west, 'align': Alignment.topRight, 'checkpoints': [Offset(0.6, 0.4), Offset(0.4, 0.6), Offset(0.6, 0.6)]},
    {'char': 'ر', 'arrow': Icons.call_made, 'align': Alignment.topLeft, 'checkpoints': [Offset(0.5, 0.4), Offset(0.4, 0.6), Offset(0.3, 0.8)]},
    {'char': 'ز', 'arrow': Icons.call_made, 'align': Alignment.topLeft, 'checkpoints': [Offset(0.5, 0.4), Offset(0.4, 0.6), Offset(0.3, 0.8)]},
    {'char': 'س', 'arrow': Icons.keyboard_arrow_down, 'align': Alignment.topRight, 'checkpoints': [Offset(0.7, 0.4), Offset(0.5, 0.4), Offset(0.3, 0.5), Offset(0.5, 0.7)]},
    {'char': 'ش', 'arrow': Icons.keyboard_arrow_down, 'align': Alignment.topRight, 'checkpoints': [Offset(0.7, 0.4), Offset(0.5, 0.4), Offset(0.3, 0.5), Offset(0.5, 0.7)]},
    {'char': 'ص', 'arrow': Icons.loop, 'align': Alignment.centerRight, 'checkpoints': [Offset(0.7, 0.5), Offset(0.5, 0.4), Offset(0.3, 0.6), Offset(0.6, 0.6)]},
    {'char': 'ض', 'arrow': Icons.loop, 'align': Alignment.centerRight, 'checkpoints': [Offset(0.7, 0.5), Offset(0.5, 0.4), Offset(0.3, 0.6), Offset(0.6, 0.6)]},
    {'char': 'ط', 'arrow': Icons.loop, 'align': Alignment.centerRight, 'checkpoints': [Offset(0.7, 0.5), Offset(0.5, 0.5), Offset(0.5, 0.3), Offset(0.5, 0.7)]},
    {'char': 'ظ', 'arrow': Icons.loop, 'align': Alignment.centerRight, 'checkpoints': [Offset(0.7, 0.5), Offset(0.5, 0.5), Offset(0.5, 0.3), Offset(0.5, 0.7)]},
    {'char': 'ع', 'arrow': Icons.reply, 'align': Alignment.topRight, 'checkpoints': [Offset(0.6, 0.3), Offset(0.4, 0.4), Offset(0.3, 0.6), Offset(0.6, 0.7)]},
    {'char': 'غ', 'arrow': Icons.reply, 'align': Alignment.topRight, 'checkpoints': [Offset(0.6, 0.3), Offset(0.4, 0.4), Offset(0.3, 0.6), Offset(0.6, 0.7)]},
    {'char': 'ف', 'arrow': Icons.loop, 'align': Alignment.topRight, 'checkpoints': [Offset(0.7, 0.4), Offset(0.5, 0.4), Offset(0.3, 0.6), Offset(0.6, 0.6)]},
    {'char': 'ق', 'arrow': Icons.loop, 'align': Alignment.topRight, 'checkpoints': [Offset(0.7, 0.4), Offset(0.5, 0.5), Offset(0.3, 0.7), Offset(0.5, 0.7)]},
    {'char': 'ك', 'arrow': Icons.arrow_downward, 'align': Alignment.topRight, 'checkpoints': [Offset(0.7, 0.3), Offset(0.7, 0.6), Offset(0.4, 0.6)]},
    {'char': 'ل', 'arrow': Icons.arrow_downward, 'align': Alignment.topRight, 'checkpoints': [Offset(0.6, 0.3), Offset(0.6, 0.6), Offset(0.4, 0.7)]},
    {'char': 'م', 'arrow': Icons.loop, 'align': Alignment.topRight, 'checkpoints': [Offset(0.6, 0.4), Offset(0.4, 0.4), Offset(0.4, 0.7)]},
    {'char': 'ن', 'arrow': Icons.keyboard_arrow_down, 'align': Alignment.topRight, 'checkpoints': [Offset(0.7, 0.4), Offset(0.5, 0.7), Offset(0.3, 0.4)]},
    {'char': 'هـ', 'arrow': Icons.loop, 'align': Alignment.centerRight, 'checkpoints': [Offset(0.6, 0.5), Offset(0.4, 0.4), Offset(0.5, 0.6)]},
    {'char': 'و', 'arrow': Icons.loop, 'align': Alignment.topRight, 'checkpoints': [Offset(0.6, 0.4), Offset(0.4, 0.5), Offset(0.3, 0.7)]},
    {'char': 'ي', 'arrow': Icons.reply, 'align': Alignment.topRight, 'checkpoints': [Offset(0.6, 0.4), Offset(0.4, 0.5), Offset(0.6, 0.7)]},
  ];

  // الأرقام كاملة من 1 إلى 10
  final List<Map<String, dynamic>> numbersList = [
    {'char': '١', 'arrow': Icons.arrow_downward, 'align': Alignment.topCenter, 'checkpoints': [Offset(0.5, 0.3), Offset(0.5, 0.5), Offset(0.5, 0.7)]},
    {'char': '٢', 'arrow': Icons.arrow_back, 'align': Alignment.topRight, 'checkpoints': [Offset(0.7, 0.3), Offset(0.4, 0.3), Offset(0.4, 0.7)]},
    {'char': '٣', 'arrow': Icons.keyboard_arrow_left, 'align': Alignment.topRight, 'checkpoints': [Offset(0.7, 0.3), Offset(0.5, 0.3), Offset(0.5, 0.7)]},
    {'char': '٤', 'arrow': Icons.loop, 'align': Alignment.topRight, 'checkpoints': [Offset(0.6, 0.3), Offset(0.4, 0.45), Offset(0.6, 0.6)]},
    {'char': '٥', 'arrow': Icons.loop, 'align': Alignment.topCenter, 'checkpoints': [Offset(0.5, 0.3), Offset(0.7, 0.5), Offset(0.5, 0.7), Offset(0.3, 0.5)]},
    {'char': '٦', 'arrow': Icons.arrow_forward, 'align': Alignment.topLeft, 'checkpoints': [Offset(0.3, 0.3), Offset(0.6, 0.3), Offset(0.6, 0.7)]},
    {'char': '٧', 'arrow': Icons.import_export, 'align': Alignment.topLeft, 'checkpoints': [Offset(0.3, 0.3), Offset(0.5, 0.7), Offset(0.7, 0.3)]},
    {'char': '٨', 'arrow': Icons.import_export, 'align': Alignment.bottomLeft, 'checkpoints': [Offset(0.3, 0.7), Offset(0.5, 0.3), Offset(0.7, 0.7)]},
    {'char': '٩', 'arrow': Icons.loop, 'align': Alignment.topRight, 'checkpoints': [Offset(0.6, 0.3), Offset(0.4, 0.4), Offset(0.6, 0.5), Offset(0.6, 0.7)]},
    {'char': '١٠', 'arrow': Icons.arrow_downward, 'align': Alignment.topCenter, 'checkpoints': [Offset(0.4, 0.5), Offset(0.6, 0.3), Offset(0.6, 0.5), Offset(0.6, 0.7)]},
  ];

  int currentIndex = 0;
  List<Offset?> points = [];
  Set<int> passedCheckpoints = {}; 
  String feedbackMessage = "تتبع السهم وابدأ الكتابة بلمس الشاشة ✍️";
  Color feedbackColor = Colors.purple;
  bool isCompleted = false;

  List<Map<String, dynamic>> get currentActiveList => widget.isLetters ? lettersList : numbersList;

  void checkDrawingAccuracy(Offset localPos, Size canvasSize, List<Offset> checkpoints) {
    if (isCompleted) return;

    bool nearAnyPath = false;
    double maxAllowedDistance = 55.0; // تحسين مسافة الحساسية لضمان سلاسة فائقة للأطفال

    for (int i = 0; i < checkpoints.length; i++) {
      Offset targetPixel = Offset(checkpoints[i].dx * canvasSize.width, checkpoints[i].dy * canvasSize.height);
      double distance = (localPos - targetPixel).distance;

      if (distance < maxAllowedDistance) {
        nearAnyPath = true;
        if (!passedCheckpoints.contains(i)) {
          setState(() {
            passedCheckpoints.add(i);
          });
        }
      }
    }

    if (nearAnyPath && !isCompleted) {
      setState(() {
        feedbackMessage = "🌟 رائع يا بطل! استمر في الرسم";
        feedbackColor = Colors.amber.shade800;
      });
    }

    if (passedCheckpoints.length == checkpoints.length && !isCompleted) {
      setState(() {
        isCompleted = true;
        feedbackMessage = "🎉 ممتاز جداً! كتابتك صحيحة ومذهلة 🏆";
        feedbackColor = Colors.green;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentItem = currentActiveList[currentIndex];
    List<Offset> checkpoints = List<Offset>.from(currentItem['checkpoints']);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isLetters ? 'مصحح الحروف الذكي' : 'مصحح الأرقام الذكي', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: currentIndex > 0 ? () {
                    setState(() {
                      currentIndex--;
                      resetCanvas();
                    });
                  } : null,
                  child: const Text('السابق', style: TextStyle(color: Colors.white)),
                ),
                Text(
                  widget.isLetters ? 'حرف: ${currentItem['char']}' : 'رقم: ${currentItem['char']}',
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.purple),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: currentIndex < currentActiveList.length - 1 ? () {
                    setState(() {
                      currentIndex++;
                      resetCanvas();
                    });
                  } : null,
                  child: const Text('التالي', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),

          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: feedbackColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: feedbackColor, width: 2)
            ),
            child: Text(
              feedbackMessage,
              textAlign: TextAlign.center,
              style: TextStyle(color: feedbackColor, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Center(
                        child: Text(
                          currentItem['char'],
                          style: TextStyle(
                            fontSize: 280,
                            fontWeight: FontWeight.w100,
                            color: isCompleted ? Colors.green.withOpacity(0.2) : Colors.grey.withOpacity(0.12),
                          ),
                        ),
                      ),
                      
                      if (!isCompleted)
                        Align(
                          alignment: currentItem['align'],
                          child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Icon(currentItem['arrow'], size: 45, color: Colors.amber.shade700),
                          ),
                        ),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: feedbackColor.withOpacity(0.3), width: 4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              points.add(details.localPosition);
                            });
                            checkDrawingAccuracy(details.localPosition, Size(constraints.maxWidth, constraints.maxHeight), checkpoints);
                          },
                          onPanEnd: (details) {
                            points.add(null);
                          },
                          child: CustomPaint(
                            painter: DrawingPainter(points: points, isSuccess: isCompleted),
                            size: Size.infinite,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12)),
              onPressed: resetCanvas,
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text('تنظيف الشاشة ومحاولة أخرى', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  void resetCanvas() {
    setState(() {
      points.clear();
      passedCheckpoints.clear();
      isCompleted = false;
      feedbackMessage = "تتبع السهم وابدأ الكتابة بلمس الشاشة ✍️";
      feedbackColor = Colors.purple;
    });
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;
  final bool isSuccess;

  DrawingPainter({required this.points, required this.isSuccess});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isSuccess ? Colors.green.shade600 : Colors.amber.shade800
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 14.0; 

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) => true;
}
