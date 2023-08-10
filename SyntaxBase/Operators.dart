///1. 赋值运算符 ??=  如果左边为空就赋值a??=b
///2. 复合赋值运算符
///   2.1 ..级联运算符 如果对象为空 ?..则不会操作后续。类似kotlin的四个扩展函数
///
main() {
  //2.1
  var sb = StringBuffer()
    ?..write('bar')
    ..isEmpty
    ..isNotEmpty;
}
