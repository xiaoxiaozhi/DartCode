///别名
typedef IntList = List<int>;
typedef ListMapper<X> = Map<X, List<X>>; //别名和泛型，好像只能使用一种泛型
typedef Compare<T> = int Function(T a, T b); // 别名和函数一起使用
main() {
  IntList il = [1, 2, 3];

  Map<String, List<String>> m1 = {}; // Verbose.
  ListMapper<String> m2 = {}; // Same thing but shorter and clearer.
}
