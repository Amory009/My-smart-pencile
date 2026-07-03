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
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.purple),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'تعلم كتابة الحروف والأرقام العربية مع السهم التوجيهي الذكي بدون إنترنت!',
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

// 2. شاشة الرسم والتتبع الذكي مع الأسهم الموجهة
class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  // الحروف مع معلومات الأسهم التوجيهية (نص الحرف، واتجاه السهم المناسب له بصرياً)
  final List<Map<String, dynamic>> itemsToLearn = [
    {'char': 'أ', 'arrow': Icons.arrow_downward, 'align': Alignment.topCenter, 'hint': 'اكتب من الأعلى لأسفل'},
    {'char': 'ب', 'arrow': Icons.arrow_back, 'align': Alignment.bottomRight, 'hint': 'اكتب من اليمين إلى اليسار ثم لأعلى'},
    {'char': 'ت', 'arrow': Icons.arrow_back, 'align': Alignment.bottomRight, 'hint': 'اكتب الطبق ثم ضع النقطتين'},
    {'char': 'ث', 'arrow': Icons.arrow_back, 'align': Alignment.bottomRight, 'hint': 'اكتب الطبق ثم ضع الثلاث نقاط'},
    {'char': 'ج', 'arrow': Icons.screen_rotation, 'align': Alignment.topRight, 'hint': 'ابدأ من الخط العلوي ثم الدوران'},
    {'char': 'ح', 'arrow': Icons.screen_rotation, 'align': Alignment.topRight, 'hint': 'ابدأ من الخط العلوي ثم الدوران'},
    {'char': 'خ', 'arrow': Icons.screen_rotation, 'align': Alignment.topRight, 'hint': 'ابدأ من الخط العلوي ثم الدوران'},
    {'char': 'د', 'arrow': Icons.south_west, 'align': Alignment.topCenter, 'hint': 'انزل منحني ثم امشِ على السطر'},
    {'char': 'ذ', 'arrow': Icons.south_west, 'align': Alignment.topCenter, 'hint': 'انزل منحني ثم ضع النقطة'},
    {'char': 'ر', 'arrow': Icons.south_west, 'align': Alignment.topRight, 'hint': 'تزحلق لأسفل السطر'},
    {'char': 'ز', 'arrow': Icons.south_west, 'align': Alignment.topRight, 'hint': 'تزحلق لأسفل السطر وضع النقطة'},
    {'char': 'س', 'arrow': Icons.subdirectory_arrow_left, 'align': Alignment.topRight, 'hint': 'اكتب السنون ثم الكأس الكبير'},
    {'char': 'ش', 'arrow': Icons.subdirectory_arrow_left, 'align': Alignment.topRight, 'hint': 'اكتب السنون والنقاط ثم الكأس'},
    {'char': 'ص', 'arrow': Icons.loop, 'align': Alignment.bottomCenter, 'hint': 'اصعد واعمل عيناً ثم الكأس'},
    {'char': 'ض', 'arrow': Icons.loop, 'align': Alignment.bottomCenter, 'hint': 'اصعد واعمل عيناً ثم الكأس والنقطة'},
    {'char': 'ط', 'arrow': Icons.loop, 'align': Alignment.bottomCenter, 'hint': 'اصعد واعمل عيناً ثم ضع العصا من أعلى'},
    {'char': 'ظ', 'arrow': Icons.loop, 'align': Alignment.bottomCenter, 'hint': 'اصعد واعمل عيناً وعصا ونقطة'},
    {'char': 'ع', 'arrow': Icons.refresh, 'align': Alignment.topRight, 'hint': 'نصف دائرة صغيرة ثم نصف دائرة كبيرة'},
    {'char': 'غ', 'arrow': Icons.refresh, 'align': Alignment.topRight, 'hint': 'نصف دائرة صغيرة وكبيرة ونقطة'},
    {'char': 'ف', 'arrow': Icons.looks, 'align': Alignment.bottomRight, 'hint': 'دائرة صغيرة ثم طبق الفاء'},
    {'char': 'ق', 'arrow': Icons.looks, 'align': Alignment.topRight, 'hint': 'دائرة ثم كأس ينزل تحت السطر ونقطتان'},
    {'char': 'ك', 'arrow': Icons.arrow_downward, 'align': Alignment.topRight, 'hint': 'انزل مستقيماً ثم امشِ واكتب الهمزة'},
    {'char': 'ل', 'arrow': Icons.arrow_downward, 'align': Alignment.topRight, 'hint': 'عصا طويلة تنزل بكأس تحت السطر'},
    {'char': 'م', 'arrow': Icons.radio_button_checked, 'align': Alignment.topRight, 'hint': 'دائرة صغيرة وانزل لأسفل'},
    {'char': 'ن', 'arrow': Icons.subdirectory_arrow_left, 'align': Alignment.topRight, 'hint': 'كأس غائر وداخله نقطة'},
    {'char': 'هـ', 'arrow': Icons.loop, 'align': Alignment.topRight, 'hint': 'دائرة كبيرة وداخلها دائرة صغيرة'},
    {'char': 'و', 'arrow': Icons.looks, 'align': Alignment.topRight, 'hint': 'رأس الفاء وجسم الراء المتزحلق'},
    {'char': 'ي', 'arrow': Icons.trending_down, 'align': Alignment.topRight, 'hint': 'شكل البطة ونقطتين تحت السطر'},
    {'char': '١', 'arrow': Icons.arrow_downward, 'align': Alignment.topCenter, 'hint': 'من الأعلى لأسفل'},
    {'char': '٢', 'arrow': Icons.arrow_back, 'align': Alignment.topRight, 'hint': 'امشِ يساراً ثم انزل لأسفل'},
    {'char': '٣', 'arrow': Icons.subdirectory_arrow_left, 'align': Alignment.topRight, 'hint': 'سنتين ثم انزل لأسفل'},
    {'char': '٤', 'arrow': Icons.trending_down, 'align': Alignment.topRight, 'hint': 'منحنيين متتاليين'},
    {'char': '٥', 'arrow': Icons.loop, 'align': Alignment.topCenter, 'hint': 'دائرة مستديرة'},
    {'char': '٦', 'arrow': Icons.arrow_forward, 'align': Alignment.topLeft, 'hint': 'امشِ يميناً ثم انزل لأسفل'},
    {'char': '٧', 'arrow': Icons.south_west, 'align': Alignment.topLeft, 'hint': 'انزل ثم اصعد لأعلى'},
    {'char': '٨', 'arrow': Icons.north_east, 'align': Alignment.bottomRight, 'hint': 'اصعد ثم انزل لأسفل'},
    {'char': '٩', 'arrow': Icons.loop, 'align': Alignment.topRight, 'hint': 'عصا وفي أعلاها دائرة'},
    {'char': '١٠', 'arrow': Icons.arrow_downward, 'align': Alignment.topCenter, 'hint': 'واحد وبجانبه نقطة'}
  ];

  int currentIndex = 0;
  List<Offset?> points = [];

  @override
  Widget build(BuildContext context) {
    var currentItem = itemsToLearn[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('تتبع السهم واكتب الحرف', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: currentIndex > 0 ? () {
                    setState(() {
                      currentIndex--;
                      points.clear();
                    });
                  } : null,
                  child: const Text('السابق', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                      points.clear();
                    });
                  } : null,
                  child: const Text('التالي', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

          // شريط التوجيه الصوتي النصي التفاعلي للأطفال
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(10)),
            child: Text(
              '💡 ${currentItem['hint']}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.purple.shade800, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),

          // لوحة الرسم (Canvas) والتتبع
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  // الطبقة الخلفية: الحرف الشفاف الكبير جداً ليوجه يد الطفل
                  Center(
                    child: Text(
                      currentItem['char'],
                      style: TextStyle(
                        fontSize: 280,
                        fontWeight: FontWeight.w100,
                        color: Colors.grey.withOpacity(0.18),
                      ),
                    ),
                  ),
                  
                  // الطبقة المتوسطة: السهم التوجيهي الذكي المتحرك لإرشاد الطفل من أين يبدأ
                  Align(
                    alignment: currentItem['align'],
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.8),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.amber.shade300, blurRadius: 12, spreadRadius: 4)
                          ]
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          currentItem['arrow'],
                          size: 36,
                          color: Colors.white,
                        ),
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
                          points.add(localPosition - const Offset(0, 130)); // ضبط حساسية اللمس للأجهزة المختلفة
                        });
                      },
                      onPanEnd: (DragEndDetails details) {
                        points.add(null);
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
                      points.clear();
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

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;

  DrawingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.amber.shade700
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 11.0; // زيادة السمك قليلاً لتسهيل الرؤية للطفل

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) => true;
}
