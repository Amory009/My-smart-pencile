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
                          MaterialPageRoute(builder: (context) => const DrawingScreen()),
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

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  final List<Map<String, dynamic>> itemsToLearn = [
    {
      'char': 'أ', 
      'arrow': Icons.arrow_downward, 
      'align': Alignment.topCenter, 
      'hint': 'اكتب من الأعلى لأسفل مستقيماً',
      'checkpoints': [Offset(0.5, 0.25), Offset(0.5, 0.45), Offset(0.5, 0.65), Offset(0.5, 0.75)]
    },
    {
      'char': '١', 
      'arrow': Icons.arrow_downward, 
      'align': Alignment.topCenter, 
      'hint': 'اكتب الرقم واحد من الأعلى لأسفل',
      'checkpoints': [Offset(0.5, 0.3), Offset(0.5, 0.5), Offset(0.5, 0.7)]
    },
    {
      'char': 'ب', 
      'arrow': Icons.arrow_back, 
      'align': Alignment.bottomRight, 
      'hint': 'ابدأ من اليمين، انزل ثم امشِ على السطر واصعد',
      'checkpoints': [Offset(0.8, 0.6), Offset(0.5, 0.65), Offset(0.2, 0.6)]
    },
    {
      'char': '٥', 
      'arrow': Icons.loop, 
      'align': Alignment.topCenter, 
      'hint': 'ارسم دائرة مستديرة بالكامل',
      'checkpoints': [Offset(0.5, 0.3), Offset(0.7, 0.5), Offset(0.5, 0.7), Offset(0.3, 0.5)]
    }
  ];

  int currentIndex = 0;
  List<Offset?> points = [];
  Set<int> passedCheckpoints = {}; 
  String feedbackMessage = "تتبع السهم وابدأ الكتابة";
  Color feedbackColor = Colors.purple;
  bool isCompleted = false;

  void checkDrawingAccuracy(Offset localPos, Size canvasSize, List<Offset> checkpoints) {
    if (isCompleted) return;

    bool nearAnyPath = false;
    double maxAllowedDistance = 45.0; 

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

    if (points.length > 5 && !nearAnyPath && points.last != null) {
      setState(() {
        feedbackMessage = "⚠️ انتبه! لقد خرجت عن مسار الحرف الصحيح";
        feedbackColor = Colors.redAccent;
      });
    } else if (nearAnyPath && !isCompleted) {
      setState(() {
        feedbackMessage = "✍️ رائع.. استمر في التتبع!";
        feedbackColor = Colors.amber.shade800;
      });
    }

    if (passedCheckpoints.length == checkpoints.length && !isCompleted) {
      setState(() {
        isCompleted = true;
        feedbackMessage = "🎉 ممتاز بطل! كتابة صحيحة 100%";
        feedbackColor = Colors.green;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentItem = itemsToLearn[currentIndex];
    List<Offset> checkpoints = List<Offset>.from(currentItem['checkpoints']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('المصحح الذكي للكتابة', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.purple,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
                  'تعلّم: ${currentItem['char']}',
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.purple),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: currentIndex < itemsToLearn.length - 1 ? () {
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

          // تم تصحيح الكلمة هنا إلى double.infinity
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
                  Size canvasSize = Size(constraints.maxWidth, constraints.maxHeight);
                  return Stack(
                    children: [
                      Center(
                        child: Text(
                          currentItem['char'],
                          style: TextStyle(
                            fontSize: 290,
                            fontWeight: FontWeight.w100,
                            color: isCompleted ? Colors.green.withOpacity(0.2) : Colors.grey.withOpacity(0.15),
                          ),
                        ),
                      ),
                      
                      if (!isCompleted)
                        Align(
                          alignment: currentItem['align'],
                          child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Icon(currentItem['arrow'], size: 40, color: Colors.amber),
                          ),
                        ),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: feedbackColor.withOpacity(0.4), width: 4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            RenderBox object = context.findRenderObject() as RenderBox;
                            Offset localPosition = object.globalToLocal(details.globalPosition);
                            Offset adjustedPos = localPosition - const Offset(0, 140);
                            
                            setState(() {
                              points.add(adjustedPos);
                            });
                            
                            checkDrawingAccuracy(adjustedPos, canvasSize, checkpoints);
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
              label: const Text('إعادة المحاولة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
      feedbackMessage = "تتبع السهم وابدأ الكتابة";
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
      ..strokeWidth = 12.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) => true;
}
