extension ListExtension<T> on List<T> {
  int get doubleLength => length * 2;

  List<T> operator -() => reversed.toList();

  List<List<T>> split(int at) => [sublist(0, at), sublist(at)];

  bool get isNullOrEmpty => this == null || this.isEmpty;
}
