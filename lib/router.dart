import 'dart:async';

import 'package:contact/providers/projectProvider.dart';
import 'package:contact/screens/projects/MyProject_manage.dart';
import 'package:contact/screens/projects/MyProject_schedule.dart';
import 'package:riverpod/riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'screens/login/login.dart';
import 'screens/login/sign_up.dart';
import 'screens/login/email.dart';
import 'screens/login/find_id.dart';
import 'screens/home/home_main.dart';
import 'screens/timetables/Timetables.dart';
import 'screens/projects/Projects.dart';
import 'screens/chat/Chat.dart';
import 'screens/myinfo/Myinfo.dart';
import 'providers/auth.dart';
import '/utils/token_keybox.dart';

var app_name = 'Kroocrew';
var user_uni_name = "중앙대";
var user_speed = '100';




final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
      initialLocation: '/login',
      /*redirect: (context, state) {
        ref.read(authStateProvider.notifier).checkAuthState();
        if(ref.watch(authStateProvider) == false) {
          return '/login';
        }
        return null;
      },*/
      routes: <RouteBase>[
        GoRoute(
          path: '/login',
          builder: (context, state) {
            return login();
          },
          routes: <RouteBase>[
            GoRoute(
            path: 'findid',
              builder: (context, state) {
                return find_id();
              },
            ),
            GoRoute(
              path: 'findpw',
              builder: (context, state) {
                return find_id();
              },
            ),
            GoRoute(
              path: 'email',
              builder: (context, state) {
                return email();
              },
                routes: <RouteBase>[
                  GoRoute(
                    path: 'signup',
                    builder: (context, state) {
                      return sign_up();
                    },
              )
          ]
            ),

          ]
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
                      return Middle();
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
                    routes: <RouteBase>[
                      GoRoute(
                        path: 'manage',
                        builder: (context, state) {
                          return ManageMyProjects(projectData: state.extra as ProjectCardData);
                        },
                      )
                    ]
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
                      return Myinfo();
                    },
                  ),
                ]
            ),
          ],
        )
      ]
  );
});