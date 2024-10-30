import 'package:freezed_annotation/freezed_annotation.dart';

part 'os.freezed.dart';

@freezed
class OS with _$OS {
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
    OS.ventura,
    OS.sonoma,
    OS.sequoia,
  ];

  const factory OS({
    required String name,
    required String version,
    required String avatar,
    required String boardId,
    required String mlb,
  }) = _OS;

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

  factory OS.ventura() => const OS(
        name: 'Ventura',
        version: '13',
        avatar: 'assets/os/ventura.jpg',
        boardId: 'Mac-B4831CEBD52A0C4C',
        mlb: '00000000000000000',
      );

  factory OS.sonoma() => const OS(
        name: 'Sonoma',
        version: '14',
        avatar: 'assets/os/sonoma.jpg',
        boardId: 'Mac-827FAC58A8FDFA22',
        mlb: '00000000000000000',
      );

  factory OS.sequoia() => const OS(
        name: 'Sequoia',
        version: '15',
        avatar: 'assets/os/sequoia.png',
        boardId: 'Mac-7BA5B2D9E42DDD94',
        mlb: '00000000000000000',
      );
}
