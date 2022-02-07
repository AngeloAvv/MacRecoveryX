import 'package:auto_route/auto_route.dart';
import 'package:macrecovery_x/pages/download_page.dart';
import 'package:macrecovery_x/pages/finish_page.dart';
import 'package:macrecovery_x/pages/folder_page.dart';
import 'package:macrecovery_x/pages/main_page.dart';
import 'package:macrecovery_x/pages/os_page.dart';
import 'package:macrecovery_x/pages/welcome_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  preferRelativeImports: false,
  routes: <AutoRoute>[
    AutoRoute(page: MainPage, path: 'main', initial: true, children: [
      AutoRoute(page: WelcomePage, path: 'welcome', initial: true),
      AutoRoute(page: OSPage, path: 'os'),
      AutoRoute(page: FolderPage, path: 'folder'),
      AutoRoute(page: DownloadPage, path: 'download'),
      AutoRoute(page: FinishPage, path: 'finish'),
    ]),
  ],
)
class $AppRouter {}
