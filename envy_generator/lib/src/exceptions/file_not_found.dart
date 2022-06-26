class FileNotFoundException implements Exception {
  final String path;

  const FileNotFoundException(this.path);

  @override
  String toString() {
    return 'FileNotFoundException: file not found at path $path';
  }
}
