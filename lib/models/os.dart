import 'package:equatable/equatable.dart';

class OS extends Equatable {
  static const values = [
    OS.lion,
    OS.mountainLion,
    OS.mavericks,
    OS.yosemite,
    OS.elCapitan,
    OS.sierra,
    OS.highSierra,
    OS.mojave,
    OS.catalina,
    OS.bigSur,
    OS.monterey,
  ];

  final String name;
  final String version;
  final String avatar;
  final String boardId;
  final String mlb;

  const OS({
    required this.name,
    required this.version,
    required this.avatar,
    required this.boardId,
    required this.mlb,
  });

  factory OS.lion() => const OS(
        name: 'Lion',
        version: '10.7',
        avatar: 'assets/os/lion.jpg',
        boardId: 'Mac-C3EC7CD22292981F',
        mlb: '00000000000F0HM00',
      );

  factory OS.mountainLion() => const OS(
        name: 'Mountain Lion',
        version: '10.8',
        avatar: 'assets/os/mountain_lion.png',
        boardId: 'Mac-7DF2A3B5E5D671ED',
        mlb: '00000000000F65100',
      );

  factory OS.mavericks() => const OS(
        name: 'Mavericks',
        version: '10.9',
        avatar: 'assets/os/mavericks.jpg',
        boardId: 'Mac-F60DEB81FF30ACF6',
        mlb: '00000000000FNN100',
      );

  factory OS.yosemite() => const OS(
        name: 'Yosemite',
        version: '10.10',
        avatar: 'assets/os/yosemite.png',
        boardId: 'Mac-E43C1C25D4880AD6',
        mlb: '00000000000GDVW00',
      );

  factory OS.elCapitan() => const OS(
        name: 'El Capitan',
        version: '10.11',
        avatar: 'assets/os/el_capitan.jpg',
        boardId: 'Mac-FFE5EF870D7BA81A',
        mlb: '00000000000GQRX00',
      );

  factory OS.sierra() => const OS(
        name: 'Sierra',
        version: '10.12',
        avatar: 'assets/os/sierra.jpg',
        boardId: 'Mac-77F17D7DA9285301',
        mlb: '00000000000J0DX00',
      );

  factory OS.highSierra() => const OS(
        name: 'High Sierra',
        version: '10.13',
        avatar: 'assets/os/high_sierra.jpg',
        boardId: 'Mac-7BA5B2D9E42DDD94',
        mlb: '00000000000J80300',
      );

  factory OS.mojave() => const OS(
        name: 'Mojave',
        version: '10.14',
        avatar: 'assets/os/mojave.jpg',
        boardId: 'Mac-7BA5B2DFE22DDD8C',
        mlb: '00000000000KXPG00',
      );

  factory OS.catalina() => const OS(
        name: 'Catalina',
        version: '10.15',
        avatar: 'assets/os/catalina.jpg',
        boardId: 'Mac-00BE6ED71E35EB86',
        mlb: '00000000000000000',
      );

  factory OS.bigSur() => const OS(
        name: 'Big Sur',
        version: '11',
        avatar: 'assets/os/big_sur.jpg',
        boardId: 'Mac-42FD25EABCABB274',
        mlb: '00000000000000000',
      );

  factory OS.monterey() => const OS(
        name: 'Monterey',
        version: '12',
        avatar: 'assets/os/monterey.jpg',
        boardId: 'Mac-E43C1C25D4880AD6',
        mlb: '00000000000000000',
      );

  @override
  List<Object?> get props => [
        name,
        version,
        avatar,
        boardId,
        mlb,
      ];
}
