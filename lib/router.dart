import 'package:riverpod/riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/login/login.dart';
import 'screens/login/sign_up.dart';
import 'screens/home/home_main.dart';
import 'screens/timetables/Timetables.dart';
import 'screens/projects/Projects.dart';
import 'screens/chat/Chat.dart';
import 'screens/myinfo/Myinfo.dart';

import 'providers/auth.dart';

var app_name = 'Kroocrew';
var user_uni_name = "중앙대";
var user_speed = '100';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
      initialLocation: '/login',
      redirect: (context, state) {
        if(ref.read(authStateProvider.notifier).state == false) {
          return '/login';
        }
        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/login',
          builder: (context, state) {
            return login();
          },
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) {
            return sign_up();
          },
        ),
        StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
            return Scaffold(
                body: navigationShell,
                bottomNavigationBar: BottomNavigationBar(
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: '홈',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.calendar_today),
                        label: '시간표',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.widgets),
                        label: '프로젝트',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.question_answer),
                        label: '톡',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: '내정보',
                      ),
                    ],
                    backgroundColor: Colors.white,
                    selectedItemColor: Color(0xff473CCE),
                    unselectedItemColor: Colors.grey,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: navigationShell.currentIndex,
                    onTap: (int index) {
                      navigationShell.goBranch(index);
                    }
                )
            );
          },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    path: '/',
                    builder: (context, state) {
                      return Middle(app_name:app_name,user_uni_name : user_uni_name, user_speed:user_speed);
                    },

                  ),
                ]
            ),
            StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    path: '/timetable',
                    builder: (context, state) {
                      return Timetables();
                    },
                  ),
                ]
            ),
            StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    path: '/projects',
                    builder: (context, state) {
                      return Projects();
                    },
                  ),
                ]
            ),
            StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    path: '/chat',
                    builder: (context, state) {
                      return Chat();
                    },
                  ),
                ]
            ),
            StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    path: '/myinfo',
                    builder: (context, state) {
                      return Myinfo(user_uni_name:user_uni_name,user_speed: user_speed,);
                    },
                  ),
                ]
            ),
          ],
        )
      ]
  );
});