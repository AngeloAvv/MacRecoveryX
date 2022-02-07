extension URIExtensions on Uri {
  String get name => path.split('/').last;
}
