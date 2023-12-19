import 'dart:async';
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
///        Future.val() val是常量等同于微任务，如果是Future则按照异步处理放到事件队列
///    1.4 多任务
///        Future.any() 返回最先完成的Future的结果
///        Future.wait() 等待所有Future执行完成，并收集所有Future的返回结果
///        Future.doWhile()按照条件遍历执行多个Future
///        Future.(集合，futures) 遍历给定的集合，按照集合执行多个Future
/// https://httpbin.org/ip 获取当前地址
/// 2. await和async实现异步函数
///    2.1 声明异步函数： Future<T> 方法名()  async {方法体} 。async声明的异步函数返回一个Future， 例如Future<void>返回空.
///        有一种例外因为 async标记的函数返回值都可以用Future包裹 返回为void、int...的函数仍然可以用Future<void或int>，这种情况就不是异步了，感觉这里是dart 没考虑的地方
///    await是等待异步方法执行完成,用来等待耗时操作的返回结果，这个操作会阻塞到后面的代码
///
/// 3. 生成器
///    生成值序列，返回一个迭代器的形式   很像kotlin的sequence
///    3.1 同步生成器,返回一个迭代器。如果只有一个值是将返回单个值，多个值将返回Iterable<T> 函数名 sync* {yield T}, 通过运行可知 一边生成一边迭代。
///    3.2 异步生成器，如果是一个值将返回Future<T> 多个值将返回返回Stream。可以看到生成器函数放到事件队列中了
///    3.3 递归生成器
/// 4. Stream
///    Future 异步返回单个值，Stream异步返回多个值，Stream就是dart中的数据流，error接收数据流失败 done接收完成状态
///    数据流图示  数据--->sink--->StreamController--->stream--->listener
///    4.1 单一监听数据流
///    StreamController()， listen监听数据流，数据流只能被订阅一次，多次会报错
///    4.2 广播流
///    StreamController.broadcast(); 广播流能监听多次
///    4.3 创建Stream实例
///    StreamController().stream
///    Stream.fromFuture()
///    Stream.fromFutures()
///    Stream.fromIterable()

main() async {
  //1.1
  final f = Future(() {
    print("123");
    return "456";
  });
  print(f); //立即返回Future，打印Future实例 Instance of 'Future<String>'
  print(await f); //多次调用 Future的computation 方法只会执行一次，结果能返回多次
  print(await f);
  //1.2
  // futureState();
  //1.3
  // futureEven();
  //1.4 多任务
  // futureMultiple();
  //2.
  // print('futureReturn---${await futureReturn()}');
  //3.1 同步生成器
  naturalsTo(3).forEach((element) {
    print('同步迭代器---$element');
  });
  //3.2
  print('start');
  asynchronousNaturalsTo(3).forEach((element) {
    print('异步迭代器---$element');
  });
  print('end');
  //4.1 单一数据流
  singleStream();
  //4.2
  broadcastStream();
  //4.3
  Stream.fromFuture(Future(() => 123)).listen((event) {
    print('Stream.fromFuture--->$event');
  }).onDone(() {
    print('完成---');
  });
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

//1.2 future状态有关的API
futureState() {
  var f = Future.delayed(Duration(seconds: 1), () {
    print('catch test');
    return "this is a catch ";
    // throw Exception("exc");
  }).catchError((error) {
    print('引发Error $error');
    return error.toString();
  }, test: (ero) => ero.runtimeType == String);
}

//1.3 用Future执行事件队列
futureEven() {
  Future(() {
    print('future task');
  });
  Future.sync(() => print('Future.sync'));
  Future.microtask(() => print('Future.microtask'));
  Future.value('常量')
      .then((value) => print('value const---$value')); //如果是常量就放入微任务队列
}

//1.4 future多任务API
futureMultiple() async {
  //----------------any------------------------
  var value = Future.any([
    Future.delayed(Duration(seconds: 1), () {
      print('any----Future.delayed0');
      return 1;
    }),
    Future.delayed(Duration(seconds: 2), () {
      print('any----Future.delayed');
      return 2;
    }),
    // Future(() {
    //   print('futureMultiple---Future()');
    //   return 3;
    // }),
  ]);
  print('Future.any----${await value}');
  //---------------
  var fff = Future.wait([
    Future.delayed(Duration(seconds: 1), () {
      print('wait----Future.delayed0');
      return 1;
    }),
    Future.delayed(Duration(seconds: 2), () {
      print('wait----Future.delayed1');
      return 2;
    }),
  ]);
  // .then((value) => print('Future.wait value---$value'))
  print('Future.wait---${await fff}');
}

//2.
Future<int> futureReturn() async {
  return 123;
}

//3.1同步生成器
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) {
    print('生成---$k');
    yield k++;
  }
}

//3.2 异步生成器
Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) {
    print('生成---$k');
    yield k++;
  }
}

//4.1单一监听数据流
singleStream() {
  //1.创建单一数据流
  var streamController = StreamController();
  //2.监听数据流
  streamController.stream.listen((event) {
    print('event-----$event');
  });
  //3.给数据流添加数据
  streamController.sink.add('abc');
  streamController.sink.add(123);
}

//4.2 广播数据流
broadcastStream() {
  //1.创建广播流
  var streamController = StreamController.broadcast();
  //2.监听数据流
  streamController.stream.listen((event) {
    print('event1-----$event');
  });
  //监听多次
  streamController.stream.listen((event) {
    print('event2-----$event');
  });
  //3.给数据流添加数据
  streamController.sink.add('abc');
  streamController.sink.add(123);
}
