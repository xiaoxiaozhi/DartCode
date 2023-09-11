import 'dart:io';

/// [异步编程：Futures、async、await] (https://dart.dev/codelabs/async-await)  官网资料写的不怎么样不如看视频
/// [Dart 进阶](https://www.bilibili.com/video/BV1gN4y1V7pq?p=11&vd_source=9cc1c08c51cf20bda524430137dc77bb)
/// 1. Future  https://api.dart.dev/stable/3.1.1/dart-async/Future-class.html
///    异步操作的结果，有三种状态 未完成、已完成(成功数据)、已完成(失败数据)
///    通过方法返回 Future、
///    手动创建  Future(() => "");
///    Future的工厂函数例如 Future.delayed()、Future.error()
///    attention 多次调用
///    1.2 跟Future 状态有关的API
///        感觉刚创建的Future的状态是未完成 ，
///        then(成功完成调用) catchError(失败完成) whenCompleted(只要完成就调用)  感觉Future状态改变才会回调这些函数，返回的Future是已完成状态
///    1.3 事件队列
///        Future(computation函数) 创建一个Future 丢到事件队里当中 Timer.run
///        Future.sync()同步任务,不会被丢到异步任务当中
///        Future.microtask()微任务 微任务队列，优先级比事件任务高
///        Future.val() val是常量等同于微任务，是异步按照异步逻辑处理
/// https://httpbin.org/ip 获取当前地址
/// 2. await和async实现异步函数
///    2.1 声明异步函数： Future<T> 方法名()  async {方法体} 。async声明的异步函数返回一个Future， 例如Future<void>返回空.
///        有一种例外  返回为void的异步函数仍然可以用Future<void>当做返回值，这种情况就没有意义了，感觉这里是dart 没考虑的地方
///    await是等待异步方法执行完成,只有async在方法中才能使用await关键字
/// 3.

main() async {
  await fetchUserOrder();
  //1.1
  final f = Future(() {
    print("123");
    return "456";
  });
  print(f); //立即返回Future，打印Future实例 Instance of 'Future<String>'
  print(await f); //多次调用 方法执行一次，值返回多次
  print(await f);
  //1.2 catchError
  var f2 = Future.delayed(Duration(seconds: 1), () {
    print('catch test');
    return "this is a catch ";
    // throw Exception("exc");
  }).catchError((error) {
    print('引发Error $error');
    return error.toString();
  }, test: (ero) => ero.runtimeType == String);
  print("1.2 catchError \n ${await f2}");
  //1.2 sync microtask
  print('1.2 sync microtask------------------------');
  //仔细观察执行顺序，
  print('start');
  Future(() {
    print('future task');
  });
  Future.sync(() => print('Future.sync'));
  Future.microtask(() => print('Future.microtask'));
  Future.value('常量').then((value) => print('value const---$value'));//如果是常量就放入微任务队列
  print('end');
}

testAsync() async {
  sleep(Duration(seconds: 1));
  return "hello async";
}

//
myFuture() {}

//2.1 为什么await 没有阻塞线程，返回
Future<void> fetchUserOrder() async {
  // Imagine that this function is fetching user info from another service or database.
  Future.delayed(const Duration(seconds: 1), () => print('Large Latte'));
}
