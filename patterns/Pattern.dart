/// 模式匹配 解构
/// 1.解构 https://juejin.cn/post/7240838046789648442#heading-0
///   1.1 对Record类型解构
///   1.2 对List类型解构
///   1.3 对Map类型解构
main() {
  //1.1 非命名类型解构
  var user = ('tony', 29);
  var (name, age) = user; // 直接解构对象
  print('======$name====${age}===');
  //1.1 命名类型解构
  var position = (x: 1, y: 3, 'p0');
  var (x: a, y: b, c) = position;
  // var (:x,:y,d) = position;//还可以这样，
  // 可以通过 冒号+key 进行简写。比如 :x 含义就是 x:x ，表示：将右侧对象中的名称为 x 的数据，为左侧的 x 变量赋值。
  print('====$a====$b====$c====');
  //1.2 对List类型解构
  List<int> numList = [1, 2, 3];
  var [d, e, f] = numList;
  print("$d $e $f");
  //1.3 对Map类型解构
  Map<String, dynamic> data = {
    'name1': 'toly1',
    'age1': 30,
  };
  var {'name1': name1, 'age1': age1} = data;
  print('======$name1====${age1}===');
}
