import 'package:flutter/material.dart';
import 'package:dislexia/main.dart';

class JuegosPage extends StatelessWidget {
  const JuegosPage({Key? key});

  @override
  Widget build(BuildContext context) {
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.all(10 * fem),
            child: Image.asset('assets/regresar.png'),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(40 * fem, 82.5 * fem, 40 * fem, 89 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xff7cd164),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 63.5 * fem),
              child: Text(
                'Juegos',
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
            Expanded(
              child: Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 24 * fem),
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
                  child: SizedBox(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 135 * fem),
                      child: Text(
                        'Sopa de letras',
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
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 24 * fem),
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
                    'Crucigrama',
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
    );
  }
}
