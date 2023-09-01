import 'dart:io';

/// https://httpbin.org/ip 获取当前地址
// import 'package:http/http.dart' as http;
//
// main() {}
//
// Future getIpAddress() {
//   final url = "https://httpbin.org/ip";
//   return http.get(url).then((response) {
//     print('$response');
//   });
// }
///async和await
///async是让方法变成异  声明一个一步函数 方法名() async {}
///await是等待异步方法执行完成,只有async在方法中才能使用await关键字
///
main() async {
  //只有在async方法中才能使用await
  print('async before ' + DateTime.now().toString());
  var result = await testAsync();
  print('async after ' + DateTime.now().toString());
}

testAsync() async {
  sleep(Duration(seconds: 1));
  return "hello async";
}
