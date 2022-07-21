import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//게시글 CRUD 클래스
class CRUDPostClass {
  // docId를 지정하는 경우 : UID를 docId로 쓰거나 문서ID를 따로 만들어 관리하고 식별해야 하는 경우 사용
  // 작성
  setDocId() {
    FirebaseFirestore.instance
        .collection('collection name')
        .doc('docId')
        .set(DataToJson()
        .toJsonMethod());
  }

  // docId를 지정할 필요가 없는 경우
  // 작성
  addPostToCollection() {
    FirebaseFirestore.instance
        .collection('collection name')
        .add(DataToJson()
        .toJsonMethod());
  }

  // 업데이트 메서드
  updatePostMethod() {
    FirebaseFirestore.instance
        .collection('collection name')
        .doc('docId')
        .update(DataToJson()
        .toJsonMethod());
  }

  // 삭제 메서드
  deletePostMethod() {
    FirebaseFirestore.instance
        .collection('collection name')
        .doc('docId')
        .delete();
  }
}

// DataToJson()클래스를 사용하는 이유는 set메서드마다 일일이 값들을 작성하는 것 보다는 클래스를 따로 만들어서 파라미터를 넘기거나 고정된 값들은 미리 채워두고 사용하는 편이 편하기 때문이다.
class DataToJson {
  Map<String, dynamic> toJsonMethod() => {
    'firestore의 문서에 추가될 필드 이름': '값',
    'firestore의 문서에 추가될 필드 이름': '값',
  };
}

// 좋아요같은 기능에는 Transaction이라는 오류방지 기능이 필요하다, 다수의 사용자가 동시에 좋아요를 누를 경우 오류가 발생할 수 있는데 이 오류를 막아주는게 Transaction이다.
// Transaction은 다양한 상황에서 쓸모가 많기 때문에 알아두는 것이 좋다.
void runTransaction() {
  // 오류가 발생할 것 같은 문서
  DocumentReference doc =
  FirebaseFirestore.instance.collection('collectionName').doc('docId');

  FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot snapshot = await transaction.get(doc);
    if (!snapshot.exists) {
      throw Exception('Does not exist');
    }
    var postMap = snapshot.data()! as Map;
    // firestore에 좋아요 기능과 관련된 필드의 이름을 likeNum이라고 가정
    // 좋아요 숫자를 + 1
    int postLikeNum = postMap['likeNum'] + 1;
    transaction.update(doc, {'likeNum': postLikeNum});
  });
}

