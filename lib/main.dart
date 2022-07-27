import 'dart:convert';
import 'dart:io';

import 'package:archive/src/home.dart';
import 'package:archive/src/provider/count_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_scraper/web_scraper.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:flutter/services.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (BuildContext context) => CountProvider(),  //child 하위에 있는 모든 위젯들은 CountProvider에 접근가능하게 됨, ChangeNotifierProvider이거는 싱글 프로바이더임 따라서 하나만 등록가능
      child: Home(),),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          child: Column(children: [
            TextField(
              controller: _control,
            ),
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: copyToClipboard,
            ),
            SizedBox(
              height: 50,
              child: ListView(
                children: [
                  Text(_data),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.paste),
              onPressed: pasteFromClipboard,
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: loadEvs,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }



  // api key
  var apiKey =
      "apiKey";

  Future loadEvs() async {




    var encodeKey = convert.utf8.encode('%2FbqbcuFciYhRZ%2BH7rTIX%2FERzQooeH891iidpEvI%2BjeZxiHj5Hlx69SG0Cs%2B0MsFYJdPt0QGqwGU56e6NQYwDSQ%3D%3D');

    print('encodeKey : ${encodeKey}');
    var decodeKey = convert.utf8.decode(encodeKey);
    print('decodeKey ;${decodeKey}');

    var keyData = encodeKey;
    String baseUrl =
        "http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcInduTrade?LAWD_CD=11110&DEAL_YMD=202206&serviceKey=${keyData}";

    print('Uri.parse(baseUrl) : ${Uri.parse(baseUrl,)}');

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






  final TextEditingController _control = TextEditingController();
  var _data = 'String Here';

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _control.text));
  }

  void pasteFromClipboard() async {
    ClipboardData? cdata = await Clipboard.getData(Clipboard.kTextPlain);

    setState(() {
      _data = cdata?.text ?? 'got null';
    });
  }


  var weather = <String>[];
  var currentTemp = '';
  var airPollution = <String>[];
  var finedust = '';
  var superFinedust = '';
  var ultraviolet = '';

  Future<List<String>> extractData() async {
//Getting the response from the targeted url
    final response =
    await http.Client().get(Uri.parse('https://ssl.pstatic.net/t.static.blog/mylog/versioning/Frameset-347491577_https.js'));
    //Status Code 200 means response has been received successfully
    if (response.statusCode == 200) {
      //Getting the html document from the response
      var document = parser.parse(response.body);
      print('document.documentElement?.classes : ${json.decode(document.documentElement!.text)}');
      try {
        //Scraping the first article title
        var responseString1 = document
            .getElementsByClassName('articles-list')[0]
            .children[0]
            .children[0]
            .children[0];

        print(responseString1.text.trim());

        //Scraping the second article title
        var responseString2 = document
            .getElementsByClassName('articles-list')[0]
            .children[1]
            .children[0]
            .children[0];

        print(responseString2.text.trim());

        //Scraping the third article title
        var responseString3 = document
            .getElementsByClassName('articles-list')[0]
            .children[2]
            .children[0]
            .children[0];

        print(responseString3.text.trim());
        //Converting the extracted titles into string and returning a list of Strings
        return [
          responseString1.text.trim(),
          responseString2.text.trim(),
          responseString3.text.trim()
        ];
      } catch (e) {
        return ['', '', 'ERROR!'];
      }
    } else {
      return ['', '', 'ERROR: ${response.statusCode}.'];
    }
  }



  Future getJSONData1Page() async {
    List tempResult = [];


    var url = 'https://openapi.naver.com/v1/search/blog?query=임진왜란이 무엇인가요?&sort=sim';
    var response = await http.get(Uri.parse(url),
        headers: {"X-Naver-Client-Id" : "l2UqN5q1Wbjrp6LQdKqV",
          "X-Naver-Client-Secret" : "CMIDekqrLZ"}
    );

    var dataConvertedToJSON = json.decode(response.body);
    //print(dataConvertedToJSON);
    for (int i = 0;  i < dataConvertedToJSON['items'].length; i++) {
      tempResult.add(dataConvertedToJSON['items'][i]['description']);
    }
    var result = dataConvertedToJSON['items'][0]['link'];
    //[{},{}]형태
    //print(result);
    //print(int.parse(result[0]['productId']));
    //print(int.parse(result[0]['productId']) is int);

    print('result : ${dataConvertedToJSON['items'][0]['link']}');
  }


  Future _getDataFromWeb() async {
    List<String> rawWeatherData = [];

    final String url =
        'https://blog.naver.com/yeonyu00/222665361660';

    //final http.Response response = await http.get(Uri.parse(url));
    //dom.Document document = parser.parse(response.body);

    var response = await http.get(Uri.parse(url));
    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = utf8.decode(response.bodyBytes);

    //print('response.body : ${response.body}');

    dom.Document document = parser.parse(response.body);
    var data = document.getElementsByTagName('description');

    //print('data : ${document.documentElement?.innerHtml}');

    var urlHttps = Uri.parse('https://blog.naver.com/https://ssl.pstatic.net/t.static.blog/mylog/versioning/Frameset-347491577_https.js');
    var responseHttps = await http.post(urlHttps,);
    print('Response status: ${utf8.decode(responseHttps.bodyBytes)}');
    /*
    print("statusCode: ${statusCode}");
    print("responseHeaders: ${responseHeaders}");
    print("responseBody: ${response.body}");

     */
    /*
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    var text = await response.transform(utf8.decoder).join();

    print('text : ${text}');

     */
    /*
    print('document : ${document.outerHtml}');
    print('document : ${document.documentElement}');


    document
        .getElementsByClassName('title')
        .forEach((dom.Element element) {
      rawWeatherData =
          element.text.replaceAll(RegExp(r"\s+"), ',').split(',').toList();
      rawWeatherData.removeAt(0);
      rawWeatherData.removeLast();

    });

    print('rawWeatherData : ${rawWeatherData[0]}');

     */


  }

  Future getJSONDataKakao() async {
    var url =
        'https://dapi.kakao.com/v2/search/blog?&page=10&query=https://blog.naver.com/sseryuni/222782148230?isInf=true';
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "KakaoAK 2385013352b15f3ab078902231b55231"});
    var dataConvertedToJSON = json.decode(response.body);
      //List result = dataConvertedToJSON['documents'][0]['contents'];

    print('response.body : ${response.body}');
  }
}

  crawlingTest() async {
    final webScraper = WebScraper('https://blog.naver.com/hyeyoon0214/222733727759');
    if (await webScraper.loadWebPage('/')) {
      var content = webScraper.getPageContent();
      //List<Map<String, dynamic>> elements = webScraper.getElement('h3.title > a.caption', ['href']);
      print(content);
    }
    /*
    HttpClient();
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse('https://blog.naver.com/hyeyoon0214/222733727759'));
    request.headers.contentType = ContentType("application", "json", charset: "utf-8");
    var response = await request.close();
    var _text = await response.transform(utf8.decoder).join();
    print('_text : ${_text}');
    httpClient.close();

     */
  }

