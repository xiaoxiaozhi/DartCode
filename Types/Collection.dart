import 'dart:collection';

///1.List,在 Dart 中，数组是 List 对象，所以大多数人只称它们为 List。
///2.Set,集合中唯一的无序集合，几何元素不能重复，没法通过索引取值，只能遍历或者转成List取值(目前搜到的是这样)
///      Set的创建方式 Set.from()、 Set<String> set = {};
///3.Map
///4.可迭代集合 https://dart.dev/codelabs/iterables
///  Iterable是可以顺序访问的元素的集合。Iterable是一个抽象类 List 和 Set 继承了Iterable。
///  TODO 为什么集合可以接收不同类型的数据 [1,"2"]  {1,"2"}
//
// List 和 Set 都是 Iterable，因此它们具有与 Iterable 类相同的方法和属性。
main() {
  //1.
  var list = [1, 2, 3]; //一个简单的list
  //2.
  var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine', 1};
  print("${halogens.runtimeType}");
  halogens.first;
  //
  var names = {}; //map空集 默认参数是
  names[0] = "sd";
  print("${names.runtimeType}");
  HashMap();
  Set.from([]).runtimeType;

  //2.Set的几种创建方式
  print("set 创建方式1 ${<String>{}.runtimeType}");
  print("set 创建方式2 ${Set.from([]).runtimeType}");
  Set<String> set = {};
  print("set 创建方式3 ${set.runtimeType}");
  print("set 创建方式4 ${Set().runtimeType}");
  print("set 创建方式5 ${Set.of([])}");
  print("set 创建方式6 ${Set.identity().runtimeType}");

  var names1 = []; //空集
  var names2 = <String>[]; //带泛型的空集
}
