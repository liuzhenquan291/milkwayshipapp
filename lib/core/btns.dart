class BtnModel {
  late String code;
  late String name;
  String? apiUrl; // 请求哪一个 url
  String? apiPath; // 跳转到哪一页

  BtnModel(
    code,
    name,
    apiUrl,
    apiPath,
  );
}
