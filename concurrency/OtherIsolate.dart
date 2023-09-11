import 'dart:isolate';
//必须是main方法
main(List<String> args, SendPort sp) {
  print('接收到的消息 $args');
  sp.send('hello ，im otherIsolate');
}
