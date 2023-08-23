import 'lib/people1.dart';
import 'dart:core';

/// https://juejin.cn/post/6844904164380639245#heading-3
/// 1.
/// 2. 构造函数(目录来自官网)
///    2.1 初始化参数列表,只能用在构造函数
///    2.2 将构造函数参数赋给实例变量
///    2.3 如果您没有声明构造函数，则会为您提供默认构造函数。默认构造函数没有参数，当我们创建了自己的构造方法时，默认的无参的构造方法将会失效，不能使用,因为Dart本身不支持函数的重载
///    2.4 构造函数无法继承，没有声明构造函数的子类只有默认构造函数（没有参数，没有名称）。
///    2.5 命名构造函数(类名.函数),Dart不支持构造函数重载，使用命名构造函数为一个类实现多个构造函数，命名构造函数调用构造函数
///    2.6 常量构造函数 const construction() 在某些情况下, 我们希望通过构造函数, 只要传入相同的参数, 那么得到的对象就是同一个
///        在Dart中判断两个对象是否是同一个的方法是通过函数identical判断, 返回值是一个布尔值
///    2.7 工厂构造函数
///    2.8 访问修饰符 dart没有private public protected这样的访问修饰符。默认public，如果属性或者方法以_开头则表示私有private
///    2.9 Getter和Setter  专门用来修饰方法，用get和set修饰的方法可以当做属性去访问
///    2.10 static 指定静态属性、方法，实例化非常消耗资源，声明静态成员可以提高程序性能，静态方法不能访问非静态成员，非静态方法可以访问静态成员，
///         静态方法不能访问this， this不能访问静态属性(还没初始化当然不能访问)
///    2.11 元数据 以@开头可以给代码标记一些额外的信息，内置的元数据 @override 复写 @required,注解命名参数，表示必填
///    2.12 继承 子类可以使用父类中可见的内容（属性或方法）；子类可以通过@override标记 被复写的方法；子类可以通过super关键字引用父类可见内容
///
///
main() {
  //2.8
  var p = People();
  p._money; //这是因为People和main函数处于同一文件，只有把类抽离出去私有修饰符才会起效
  var p1 = People1();
  // p1._money;//抽离出去后就访问不到了
  //2.9
  var c = Circle(10);
  print("old area---${c.area}");
  c.setR = 20;
  print("new area---${c.area}");
  //2.12
  print("${Father().name}--${Son().name}");//子类调用父类可见属性
  Son().say();//子类调用父类可见方法
  Son().look();//子类出现和父类同名的方法，默认覆写可以不加@override，dart不支持重载
}

class Point {
  final double x;
  final double y;

  // Sets the x and y instance variables
  // before the constructor body runs.
  Point(this.x, {this.y = 10}); //这个是初始化参数列表吗？？？
}

class Model {
  String? name;

  int? age;

  Model(this.name, this.age); //初始化形式引入的变量是隐式final的，并且仅在初始化列表的范围内。这句怎么理解

  //2.5 命名构造函数
  Model.withNameAndAge(String name, int age) {
    this.name = name;
    this.age = age;
  }

  //2.5 命名构造函数
  Model.withNameAndAge2(this.name, this.age);

  //2.5 命名构造函数--重定向
  Model.withNameAndAge1(String name) : this(name, 0);

//2.6 常量构造函数
// const Model.withConst(String name) : this(name, 0);

// 为什么不能解构呢？？？
// Model.initJson(Map<String, int> map) {
//   {"name": this.name, "age": this.age} = map;
// }
}

class People {
  String? name;
  num _money = 1000;

  set setName(String value) {
    this.name = value;
  }

  // getter
  String get getName {
    return 'titanjun';
  }

  //2.1 B站老师提供了以下四种初始化列表的方式 https://www.bilibili.com/video/BV1rN411Z7JH?p=28&vd_source=9cc1c08c51cf20bda524430137dc77bb
  // People(this.name);//2.1 官方只提供了这种形式,官网真垃圾，课程都讲不明白
  People() : name = "李四";
// People([String name = "李四"]){// 列表当做构造函数参数吗？？？
//   this.name = name;
// }
// 命名构造函数重定向也属于一种初始化
}

class Circle {
  final double PI = 3.1415926;
  num r;

  Circle(this.r);

  num get area {
    //get 修饰的方法去掉()
    return PI * r * r;
  }

  set setR(r) {
    this.r = r;
  }
}

class Father {
  num money = 1000;
  String name = "刘备";

  say() {
    print("我是$name");
  }
  look(){
    print("father look");
  }
}

class Son extends Father {
  @override
  look(){
    print("son look");
  }
}
