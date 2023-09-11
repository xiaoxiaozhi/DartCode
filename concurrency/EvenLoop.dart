import 'dart:async';
import 'dart:io';
import 'dart:isolate';

/// 1. 单线程  事件循环
/// dart单线程核心包括：主线程(同步)、微任务(异步)、宏任务(异步)。
/// 微任务队列：scheduleMicrotask调度，先进先出 微任务优先级高于事件任务
/// 事件队列：外部事件比如I/O 绘制 Timer   先进先出
/// 微任务执行完之后会判断微任务队列是否为空，不为空继续执行，为空开始执行事件队列，事件执行完会判断微任务队列是否为空，不为空执行微任务队列
///
/// 函数执行的时候会先执行作用域范围内的子函数，本例中子函数有四个分别是 print() 、Timer.run 、scheduleMicrotask、print
/// [这一集视频讲的非常清楚](https://www.bilibili.com/video/BV1gN4y1V7pq?p=6&vd_source=9cc1c08c51cf20bda524430137dc77bb)
/// 2. isolate 多线程
///    需要引入 import 'dart:isolate';
///    dart中的线程是以隔离的方式存在，多个线程之间不共享内存,也就不存在锁，所有的dart代码都运行在isolate，多线程解决耗时较长的异步任务
///    isolate类管理线程 创建 暂停 杀死
///    isolate.spawn(函数，消息)创建线程 ，很类似java的创建线程，第一个参数是运行在线程中的 方法，第二个参数是传给方法的参数(原始数据、SendPort实例、前两者集合)
///    isolate.pause 暂停
///    isolate.kill 杀死线程
/// 3. 多线程之间沟通
///    SendPort和ReceivePort，ap.send(发送消息)  rp.listen(接收消息)如果收到消息后不想再监听调用rp.close
///    3.1 单向通信
///        Isolate.spawn(传入一个send)实现单向通信
///    3.2 双向通信
///        Isolate.spawn(线程A的send)  线程B创建send， 然后把sendB发送给线程A，这样每个isolate都拥有对方的send。以此来实现双向通信
/// 4. Isolate.spawnUri
///    通过文件创建线程，文件里面的方法名必须是main， 参数就是构建isolate时候传进去的。
///
///
main() {
  //1.
  // evenLoop();
  //2.
  // multiThread();
  //3.1 单向通信
  // multiThread1();
  //3.1 双向通信
  // multiThread2();
  //4.
  multiThread3();
}

//1. 事件循环
evenLoop() {
  print('flow start');
  Timer.run(() {
    //main函数 执行到Timer的时候放入事件队列
    print('event-A');
    scheduleMicrotask(() {
      print('microtask-B in event-A');
    });
    scheduleMicrotask(() {
      print('microtask-C in event-A');
    });
  });

  scheduleMicrotask(() {
    //main函数 执行到scheduleMicrotask的时候放入微任务队列
    print('microtask-A');
    Timer.run(() {
      print('event-B in microtask-A');
    });
  });
  print('flow end'); //执行到这里的时候已经没有可以执行的同步任务了，此时开始事件轮询
}

//2.
multiThread() {
  print('multiThread start');
  print('当前线程' + Isolate.current.debugName!);
  Isolate.spawn((message) {
    print('spawn创建线程---' + Isolate.current.debugName! + "   $message");
  }, "word", debugName: "hello"); //debugName 线程名称
  print('multiThread end');
}

//3.1 单向通信
multiThread1() {
  print('multiThread start');
  print('当前线程---' + Isolate.current.debugName!);
  ReceivePort rpA = ReceivePort(Isolate.current.debugName!)
    ..listen((message) {
      print('listen---$message');
    }); //实现onError 怎么报错了
  SendPort spA = rpA.sendPort;
  Isolate.spawn((sp) {
    sleep(Duration(seconds: 1));
    sp.send('来自${Isolate.current.debugName}的消息');
  }, spA, debugName: '线程A');
  print('multiThread end');
}

//3.2 双向通信
multiThread2() {
  print('multiThread start');
  print('当前线程---' + Isolate.current.debugName!);
  ReceivePort rpA = ReceivePort(Isolate.current.debugName!)
    ..listen((message) {
      switch (message) {
        case SendPort sp:
          sp.send("来自${Isolate.current.debugName}的消息");
          break;
        case String str:
          print('线程${Isolate.current.debugName}收到---$str');
          break;
      }
    }); //实现onError 怎么报错了
  SendPort spA = rpA.sendPort;
  Isolate.spawn((sp) {
    ReceivePort rp2 = ReceivePort(Isolate.current.debugName!)
      ..listen((message) {
        print('线程${Isolate.current.debugName}收到---$message');
      });
    sp.send(rp2.sendPort);
    sp.send('来自${Isolate.current.debugName}的消息');
  }, spA, debugName: '线程A');
  print('multiThread end');
}

//4.
multiThread3() {
  ReceivePort rp = ReceivePort("spawnUri");
  rp.listen((message) {
    print('线程${Isolate.current.debugName}收到消息---' + message.toString());
  });
  Isolate.spawnUri(
      Uri(path: 'OtherIsolate.dart'),
      // 同文件夹下不需要过多路径，里面其实是新线程运行的方法，参数就是后面传进去的那两个
      ['1', '2', '3'],
      rp.sendPort);
}
