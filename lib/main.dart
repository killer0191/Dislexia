import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dislexia/pages/vocabulario.dart';
import 'package:dislexia/pages/juegos.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Controlar la orientación de la pantalla para que siempre sea vertical
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    double fem = 1.0;
    double ffem = 1.0;

    TextStyle safeGoogleFont(String font,
        {double? fontSize,
        FontWeight? fontWeight,
        double? height,
        Color? color}) {
      return TextStyle(
        fontFamily: font,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        color: color,
      );
    }

    return Scaffold(
      backgroundColor:
          const Color(0xff7cd164), // Establecer el color de fondo del Scaffold
      body: Padding(
        padding: EdgeInsets.only(
            top: 24 * fem), // Espacio para compensar el app bar eliminado
        child: OrientationBuilder(
          builder: (context, orientation) {
            return ListView(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                      40 * fem, 31.5 * fem, 40 * fem, 100 * fem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 83.5 * fem),
                          child: Text(
                            'Dislexia',
                            textAlign: TextAlign.center,
                            style: safeGoogleFont(
                              'JetBrains Mono',
                              fontSize: 40 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.32 * ffem / fem,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VocabularioPage(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 68 * fem),
                          width: double.infinity,
                          height: 232 * fem,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff000000)),
                            color: const Color(0xff2f2e30),
                            borderRadius: BorderRadius.circular(40 * fem),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x3f000000),
                                offset: Offset(0 * fem, 4 * fem),
                                blurRadius: 2 * fem,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Vocabulario',
                              textAlign: TextAlign.center,
                              style: safeGoogleFont(
                                'JetBrains Mono',
                                fontSize: 32 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.32 * ffem / fem,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JuegosPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 232 * fem,
                          decoration: BoxDecoration(
                            color: const Color(0xff2f2e30),
                            borderRadius: BorderRadius.circular(40 * fem),
                          ),
                          child: Center(
                            child: Text(
                              'Juegos',
                              textAlign: TextAlign.center,
                              style: safeGoogleFont(
                                'JetBrains Mono',
                                fontSize: 32 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.32 * ffem / fem,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
