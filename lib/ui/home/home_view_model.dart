
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_remind/data/model/todo.dart';
// 1. 상태클래스 만들기 : List<Todo>

// 2. 뷰모델 만들기
class HomeViewModel extends Notifier<List<Todo>> {
  @override
  List<Todo> build() {
    loadTodoList();
    return [];
  }

  // 1) 전체리스트 불러오기 옮기기
  void loadTodoList() async {
    // 전체 TODOlist fierstore 가져오기
    // 1. Firestore 인스턴스 가지고 오기
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // 2. 컬렉션 참조 만들기
    CollectionReference colRef = firestore.collection("todo_data");
    // 3. 모든 문서 불러오기
    QuerySnapshot snapshot = await colRef.get();
    List<QueryDocumentSnapshot> documentList = snapshot.docs;
    // 4. 가지고온 데이터를 변환해주기//
    List<Todo> newList = [];

    for (var doc in documentList) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Map<String, dynamic> datawithId = {
        ...data,
        "id": doc.id,
      };
      newList.add(Todo.fromJson(datawithId));
    }

    // 리버팟에서 상태 업데이트 할 때 setState 사용 X
    // => state 라는 곳에 값을 할당해주면 UI에 자동으로 반영되게 해줌!
    state = newList;
  }

  // 2) 투두 작성 옮기기
  void writeTodo(String content) async {
    //
    //// content라는 변수의 값을
    // firestore 내 todo_data 라는 컬렉션에 저장

    // firestore에 저장할때 해야하는 순서
    // 1. Firebase 인스턴스(객체) 가지고 오기
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // 2. 가지고온 Firebase 객체의 메서드를 사용해서 컬렉션 참조 만들기
    CollectionReference collectionRef = firestore.collection('todo_data');
    // 3. 만든 컬렉션 참조를 이용해서 문서 참조 만들기
    DocumentReference docRef = collectionRef.doc();
    // 4. 문서참조 이용해서 데이터 저장하기
    // 키 - 값 쌍으로 값을 저장
    Map<String, dynamic> data = {
      'isDone': false,
      'content': content,
    };
    await docRef.set(data);
    loadTodoList();
  }

  // 3) 투두 수정 옮기기
  void updateTodo(Todo todo) async {
    // 현재 false 일떄 => true 로 업데이트
    // 현재 ture 일때 => false 로 업데이트
    // 1. 파이어스토어 인스턴스 가지고오기
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // 2. 컬렉션 참조 만들기
    CollectionReference colRef = firestore.collection('todo_data');
    // 3. 문서 참조 만들기
    DocumentReference docRef = colRef.doc(todo.id);
    // 4. 문서 참조 이용해서 문서 업데이트
    bool current = todo.isDone;
    bool nextValue = !current;
    await docRef.update({
      'isDone': nextValue,
    });
    loadTodoList();
  }

  // 4) 투두 삭제 옮기기
  void deleteTodo(Todo todo) async {
    // 1. firestore 인스턴스 가지고오기
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // 2. 컬렉션 참조 만들기
    CollectionReference colRef = firestore.collection('todo_data');
    // 3. 컬렉션 참조로 특정 문서에 대한 문서참조 만들기. =>
    DocumentReference docRef = colRef.doc(todo.id);
    // 4. 삭제
    await docRef.delete();
    loadTodoList();
  }
}

// 3. 뷰모델을 공급해주는 관리자 만들기
final homeViewModelProvider = NotifierProvider <HomeViewModel, List<Todo> >(
() { return HomeViewModel();

}
);