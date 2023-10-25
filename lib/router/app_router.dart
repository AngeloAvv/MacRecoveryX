import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:macrecovery_x/models/os.dart';
import 'package:macrecovery_x/pages/download_page.dart';
import 'package:macrecovery_x/pages/finish_page.dart';
import 'package:macrecovery_x/pages/folder_page.dart';
import 'package:macrecovery_x/pages/main_page.dart';
import 'package:macrecovery_x/pages/os_page.dart';
import 'package:macrecovery_x/pages/welcome_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: MainRoute.page,
          children: [
            AutoRoute(
              page: WelcomeRoute.page,
              initial: true,
              path: 'welcome',
            ),
            AutoRoute(
              page: OSRoute.page,
              path: 'os',
            ),
            AutoRoute(
              page: FolderRoute.page,
              path: 'folder',
            ),
            AutoRoute(
              page: DownloadRoute.page,
              path: 'download',
            ),
            AutoRoute(
              page: FinishRoute.page,
              path: 'finish',
            ),
          ],
        ),
      ];
}
