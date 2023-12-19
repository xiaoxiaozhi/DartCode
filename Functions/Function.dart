///没有参考官网,笔记来自 https://www.bilibili.com/video/BV1rN411Z7JH?p=17&vd_source=9cc1c08c51cf20bda524430137dc77bb\
/// 函数也有自己的类型Function，是类型就可以声明变量 [Function class](https://api.dart.dev/stable/3.1.1/dart-core/Function-class.html) 函数类型类
/// 格式：返回值 Function(参数类型) 变量名 例如  String Function(int) fun  不过只能用别的函数给它赋值，自己无法拥有函数体
/// Function类型也有call 函数调用call函数效果和调用它自己一样
/// 1. 普通函数 Dart声明函数不需要Function关键字，函数可以省掉返回值类型表达式
/// 2. 箭头函数，(视频说也叫lambda函数，是这样吗？)  ()=>{函数体只能写一行},不能有;分号,如果不带{}那就是一条语句结尾要加分号;
/// 3. 匿名函数,(参数){函数体}；没有函数名称的函数叫匿名函数，匿名函数可以赋给变量
/// 4. 必填参数，就是函数的普通参数
/// 5. 可选参数,用[]包括,可以填也可以不填
/// 6. 命名参数，用{}包括,也是可填可不填,用required关键字强制调用时候赋值，调用的时候必须用 变量名:值 的形式，
/// 7. 函数参数，函数当做参数传入
/// 8. 作用域和闭包, 内层可以访问外层变量，反之则不行
/// 9. 异步函数,
///
main() {
  String numberToString(int n) => "$n";
  String Function(int) fun = numberToString; //经常当做方法参数
  fun.call(1);//等同于调用自己

  //1.
  printInfo();
  //2.箭头函数
  (value) => print(value); //只能有一句,一般当函数参数传入
  //3.匿名函数
  var myPrint = (value) {
    print(value);
  };
  myPrint("匿名");
  //4.必填参数
  userInfo("李四");
  //6.命名参数
  userInfo2("张三", age: 10);
}

//1.
printInfo() {
  print("你好 dart");
}

userInfo(String name) {
  print(name);
}

//5. 可选参数
userInfo1(String name, [int? age]) {
  // age默认值是null与int类型冲突所以报错，解决办法 dynamic、默认值、可空类型
  print(name);
}

//6. 命名参数
userInfo2(String name, {int age = 0}) {
  print(name);
}
