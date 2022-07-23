import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';


class GetOpenApiData {
  // 인증키
  var serviceKey = "%2FbqbcuFciYhRZ%2BH7rTIX%2FERzQooeH891iidpEvI%2BjeZxiHj5Hlx69SG0Cs%2B0MsFYJdPt0QGqwGU56e6NQYwDSQ%3D%3D";
  // 지역코드
  var lawdCd = "11110";
  // 계약년월
  var dealYMD = "202206";
  // 옵셔널 - 한 페이지 결과수
  int numOfRows = 10;
  // 옵셔널 - 페이지번호
  int pageNu = 1;


  Future loadData() async {

    String baseUrl =
        "http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcInduTrade?LAWD_CD=${lawdCd}&DEAL_YMD=${202206}&serviceKey=${serviceKey}";
    final response = await http.get(Uri.parse(baseUrl));

    // 정상적으로 데이터를 불러왔다면
    if (response.statusCode == 200) {

      // 데이터 가져오기
      final body = convert.utf8.decode(response.bodyBytes);

      // xml => json으로 변환
      final xml = Xml2Json()..parse(body);
      final json = xml.toParker();

      // 필요한 데이터 찾기
      Map<String, dynamic> jsonResult = convert.json.decode(json);
      print('jsonResult: ${jsonResult}');
      /*
      final jsonEv = jsonResult['response']['body']['Sigungu'];

      // 필요한 데이터 그룹이 있다면
      if (jsonEv['item'] != null) {
        // map을 통해 데이터를 전달하기 위해 객체인 List로 만든다.
        List<dynamic> list = jsonEv['item'];

        // map을 통해 Ev형태로 item을  => Ev.fromJson으로 전달
        //return list.map<Ev>((item) => Ev.fromJson(item)).toList();

      }

       */

    }
  }
}