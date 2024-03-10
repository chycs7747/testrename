import 'package:flutter/material.dart';
import 'package:danmoa/flutter_flow/flutter_flow_theme.dart';
import 'package:danmoa/flutter_flow/flutter_flow_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:danmoa/page1_1.dart';
import './style.dart' as style;
import './storage.dart' as storage;
import 'package:provider/provider.dart'; 

void main() {
  runApp(
   MaterialApp(
      theme: style.theme,
      home: const DanMoa(),
      routes: {
        '/page1_1': (context) => const Page1_1(),
      },
    ),

  );
}

class DanMoa extends StatelessWidget {
const DanMoa({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      
      body: Column(
        mainAxisSize: MainAxisSize.max, // Column을 AppBar과 BottmBar 사이에 매움
        children: [
          Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 200, 0, 0), // EdgeInsetsDirectional과 달리 좌우방향 고정
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/danmoa.png',
                  fit: BoxFit.cover,
                ),
              )
            ),
          ),
          // const Text('단모아'),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 90, 0, 0),
            child: FFButtonWidget(
              onPressed: () async {
                Navigator.of(context).pushNamed('/page1_1');
              },
              text: 'Kakao 로그인',
              icon: const FaIcon(
                FontAwesomeIcons.solidComment,
              ),
              options: FFButtonOptions(
                width: 300,
                height: 40,
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                color: FlutterFlowTheme.of(context).warning,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Readex Pro',
                      color: Colors.white,
                    ),
                elevation: 3,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          // Generated code for this Button Widget...
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
            child: FFButtonWidget(
              onPressed: () {
                print('Button pressed ...');
              },
              text: 'Google 로그인',
              icon: const FaIcon(
                FontAwesomeIcons.google,
              ),
              options: FFButtonOptions(
                width: 300,
                height: 40,
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                color: FlutterFlowTheme.of(context).secondary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Readex Pro',
                      color: Colors.white,
                    ),
                elevation: 3,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )
        ],
      )
    );        //bottomNavigationBar: BottomNavigationBar(items: items),
  }
}