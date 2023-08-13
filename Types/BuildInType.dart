///1.内置类型
/// int, double String,bool, Null ,集合(List,Set,arrays,Map),Runes,Symbol,记录Records
/// 1.06 在dart中 数组是List对象, Set{} List[]
///      dart支持在List、Map、Set中使用 展开运算符... 和 带可空的展开运算符...?,只能在初始化阶段使用展开运算符
///      在集合中使用控制语句 if/for
/// 1.11 记录由 非命名数据类型 + 各命名类型组成；非命名类型数据可以通过 $index 进行访问；命名类型数据可以通过 名称 进行访问：
///      https://juejin.cn/post/7233067863500849209
///2.Dart语言中也有特殊的角色
///  Object ：除 Null 之外的所有Dart类的超类。
///  Enum ：所有枚举的超类。
///  Future 和 Stream ：用于异步支持。
///  Iterable ：用于for-in循环和同步发生器功能
///  Never ：表示表达式永远无法成功完成计算。最常用于总是抛出异常的函数。
///  dynamic ：表示要禁用静态检查。通过 dynamic 变量可以定义任何数据类型 , 在编译时会使 Dart 语言的静态语法检查失效 ;
///  void ：表示某个值从未被使用。常用作返回类型。
main() {
  //1.06
  var names = <String>[]; //空List
  var names1 = <String>{}; //空Set
  // var maps = {键,值};//健和值可以使任意类型
  var list = [1, 2, 3];
  var list2 = [0, ...list];
  print("展开运算符---$list2"); //Map怎么使用展开运算符
  var map1 = {"key1": 1, "key2": 2, "key3": 3};
  var map2 = {'key4': 4, "key5": 5, "key6": 6};
  var map3 = {...map2}; //所有集合类只能在初始化的时候使用展开运算符
  map3.addAll({"key7": 7}); //不能用展开运算符
  var promoActive = true;
  var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  var listOfInts = [1, 2, 3];
  var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  //1.08 通常使用\uXXXX的方式来表示Unicode字符, 这里的XXXX是4个16进制的数, 如，心形符号(♥)的 Unicode 为\u2665。
  const emojiHeart = '♥';
  print(emojiHeart.runes); // (9829)
  //1.09 记录
  var record = ('first', a: 2, b: true, 'last',names); //first 和 last是非命名, names变量属于非命名
  print("${record.$1}   ${record.$2}  ${record.a}  ${record.b} ");
  print(record.runtimeType.toString());
  //2.6 dynamic
  dynamic d = "张三";
  // d.getName();//运行时才会检查出来
}
