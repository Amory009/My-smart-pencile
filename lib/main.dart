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

// 1. الشاشة الترحيبية الرئيسية
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
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.purple, fontFamily: 'Sans'),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'تعلم كتابة الحروف والأرقام العربية بسلاسة متناهية وبدون إنترنت!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 35),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shadowColor: Colors.amberAccent,
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      ),
                      onPressed: () {
                        // الانتقال الفوري لشاشة الرسم والتتبع
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

// 2. شاشة الرسم والتتبع الذكي
class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  // قائمة الحروف والأرقام ليتعلمها الطفل
  final List<String> itemsToLearn = [
    'أ', 'ب', 'ت', 'ث', 'ج', 'ح', 'خ', 'د', 'ذ', 'ر', 'ز', 'س', 'ش', 'ص', 'ض', 'ط', 'ظ', 'ع', 'غ', 'ف', 'ق', 'ك', 'ل', 'م', 'ن', 'هـ', 'و', 'ي',
    '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩', '١٠'
  ];

  int currentIndex = 0;
  List<Offset?> points = []; // تخزين نقاط الرسم بالإصبع

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تتبع واكتب الحرف', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.purple,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // لوحة التحكم العلوية لاختيار الحرف
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: currentIndex > 0 ? () {
                    setState(() {
                      currentIndex--;
                      points.clear(); // مسح اللوحة عند الانتقال
                    });
                  } : null,
                  child: const Text('السابق', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                Text(
                  'تعلّم: ${itemsToLearn[currentIndex]}',
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.purple),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: currentIndex < itemsToLearn.length - 1 ? () {
                    setState(() {
                      currentIndex++;
                      points.clear();
                    });
                  } : null,
                  child: const Text('التالي', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

          // لوحة الرسم (Canvas) والتتبع
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  // الطبقة الخلفية: الحرف الشفاف الكبير جداً ليقوم الطفل بتتبعه
                  Center(
                    child: Text(
                      itemsToLearn[currentIndex],
                      style: TextStyle(
                        fontSize: 280,
                        fontWeight: FontWeight.w100,
                        color: Colors.grey.withOpacity(0.18), // شفاف ليعمل كمرشد
                      ),
                    ),
                  ),
                  
                  // الطبقة الأمامية: لوحة اللمس والرسم الفعلي بسلاسة فلاتر
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple.shade200, width: 4),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                    ),
                    child: GestureDetector(
                      onPanUpdate: (DragUpdateDetails details) {
                        setState(() {
                          RenderBox object = context.findRenderObject() as RenderBox;
                          Offset localPosition = object.globalToLocal(details.globalPosition);
                          // خصم المسافة التقريبية لـ AppBar والتحكم العلوي لضبط دقة اللمس
                          points.add(localPosition - const Offset(0, 110)); 
                        });
                      },
                      onPanEnd: (DragEndDetails details) {
                        points.add(null); // قفل الخط المكتوب عند رفع الإصبع
                      },
                      child: CustomPaint(
                        painter: DrawingPainter(points: points),
                        size: Size.infinite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // أزرار التحكم السفلية (الممسحة)
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                    setState(() {
                      points.clear(); // مسح اللوحة بالكامل
                    });
                  },
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text('امسح اللوحة', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// الرسام الخاص برسم الخطوط الملونة بسلاسة تامة على الشاشة
class DrawingPainter extends CustomPainter {
  final List<Offset?> points;

  DrawingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.amber.shade700 // لون قلم التلوين الخاص بالطفل
      ..strokeCap = StrokeCap.round // جعل أطراف الخط دائرية وجميلة
      ..strokeWidth = 10.0; // سمك الفرشاة لتناسب أصابع الأطفال

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) => true;
}
