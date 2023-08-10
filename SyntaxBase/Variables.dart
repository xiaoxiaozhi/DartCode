
///1.const和final的区别 [以下几点官网没介绍全](https://blog.csdn.net/mqdxiaoxiao/article/details/102598830)
///  1.1 const的值必须在编译时就确定，final的值可以再运行时才确定
///  1.2 const修饰的值必须在初始化的时候就确定，final不必
///  1.3 const对象的值不可变是深度递归的，其内部成员的值也都是不可变的
///  1.4 被const修饰的相同对象只会被创建一次
///  1.5 const也可以用来创建常量构造函数
///2.
void main() {
  print('Hello, World!');
  int? lineCount = null;
  // late String temperature = readThermometer();//如果变量从未使用过，则不会调用函数像kotlin的 by lazy

  //1.const和final的区别
  // const time = DateTime.now();const 修饰的值必须在编译时就确定，该例运行时取得值报错
  final time = DateTime.now(); //final的值可以再运行时才确定
  //1.2
  final String time1;
  time1="123";
  print("$time1");
  //1.3
  const list = [1, 2, 3];
  // list[0] = 10; 不可变
  print(list);
  //1.4
  final list1 = [1, 2, 3];
  final list2 = [1, 2, 3];
  print(list1 == list2);//返回 true
}
