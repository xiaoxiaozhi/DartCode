import 'dart:collection';

///1.List,在 Dart 中，数组是 List 对象，所以大多数人只称它们为 List。
///2.Set,集合中唯一的无序集合，几何元素不能重复，没法通过索引取值，只能遍历或者转成List取值(目前搜到的是这样)
///      Set的创建方式 Set.from()、 Set<String> set = {};
///3.Map
///4.可迭代集合 https://dart.dev/codelabs/iterables
///  Iterable是可以顺序访问的元素的集合。Iterable是一个抽象类 List 和 Set 继承了Iterable。
///  Iterable没有实现[]操作符也就是说 iterable[1]是错误的，不过可以用 iterable.elementAt(1);替代
///  4.1 检索元素
///       for-in：for (final element in iterable) 遍历元素最简单的形式
///       iterable.first()、iterable.last()
///       iterable.firstWhere()取满足条件的第一个元素
///       singleWhere()仅有一个满足条件的元素时，返回该元素；多个的时候报错，即时设置了orElse仍会报错；没有满足条件的元素时，返回 orElse 指定的返回值
///       every() 校验每个元素是否满足某种条件，如果每个元素都满足，就返回true否则返回false；any()至少有一个元素满足
///  4.2 过滤
///      iterable.where()找出满足条件的所有元素，如果没有返回一个空迭代器
///      iterable.takeWhile() 方法从索引 0 位置处，查询满足指定条件的元素，直到出现第一个不符合条件的元素，然后返回前面符合条件的元素.如果没有返回一个空迭代器
///      iterable.skipWhile() 根据指定条件，找到第一个不符合条件的元素，然后将该元素以及后面的所有元素返回.如果没有返回一个空迭代器
///  4.3 映射
///      map() 每个元素经过方法转换成新的元素，返回一个迭代器。Map ()返回一个惰性 Iterable，这意味着只有在迭代元素时才调用提供的函数。
///
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
  //4
  Iterable<int> iterable = [8, 12, 4, 1, 17, 0, 10];
  //4. firstWhere
  print(iterable.firstWhere((element) => element > 1, orElse: () => 0));//没有找到就返回orElse
  //4. every
  print(iterable.every((element) => element>1));
  //4.2 takeWhile
  print("takeWhile ${iterable.takeWhile((element) => element>1)}");
  //4.2 skipWhile
  print("skipWhile ${iterable.skipWhile((element) => element>1)}");//返回该元素以及后面的元素



}
