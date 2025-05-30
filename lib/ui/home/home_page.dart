import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_remind/ui/home/todo_item.dart';

// todolist fierstore
// => homePage  최초한번

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> todoDatas = [];

  @override
  void initState() {
    super.initState();
// HomePage 들어왔을 때 최초 한번만 실행되는곳!
    loadTodoList();
  }

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
    List<Map<String, dynamic>> newList = [];

    for (var doc in documentList) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Map<String, dynamic> datawithId = {
        ...data,
        "id": doc.id,
      };
      newList.add(datawithId);
    }

    setState(() {
      todoDatas = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF5714E6),
        foregroundColor: Colors.white,
        onPressed: () {
          // TODO 키보드 가리기
          showModalBottomSheet(
            context: context,
            builder: (context) {
              String content = "";
              return Container(
                height: 300,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 할일 글자
                    const Text('할일'),
                    const SizedBox(height: 11),
                    // 글자 입력하는 테스트필드
                    TextField(
                      onChanged: (value) {
                        content = value;
                      },
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1F2024),
                      ),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF1414E6),
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    // 저장 버튼
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // content라는 변수의 값을
                          // firestore 내 todo_data 라는 컬렉션에 저장

                          // firestore에 저장할때 해야하는 순서
                          // 1. Firebase 인스턴스(객체) 가지고 오기
                          FirebaseFirestore firestore =
                              FirebaseFirestore.instance;
                          // 2. 가지고온 Firebase 객체의 메서드를 사용해서 컬렉션 참조 만들기
                          CollectionReference collectionRef =
                              firestore.collection('todo_data');
                          // 3. 만든 컬렉션 참조를 이용해서 문서 참조 만들기
                          DocumentReference docRef = collectionRef.doc();
                          // 4. 문서참조 이용해서 데이터 저장하기
                          // 키 - 값 쌍으로 값을 저장
                          Map<String, dynamic> data = {
                            'isDone': false,
                            'content': content,
                          };
                          docRef.set(data);
                          Navigator.pop(context);
                        },
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Color(0xFF5714E6),
                          ),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                        child: const Text(
                          '저장',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'TODO 리스트',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 1),
          child: Container(
            height: 1,
            // FF => 255
            // 불투명도 0~255
            // 0x00
            color: const Color(0xFFDCDCDC),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
          itemBuilder: (context, index) {
            Map<String, dynamic> todo = todoDatas[index];
            // {"isDone"} : false, "content" : "hi" "id" : sdfsafsdfsfd}
            print(todo);

            return TodoItem(
                isChecked: todo["isDone"],
                text: todo["content"],
                onDelete: () async {
                  // 1. firestore 인스턴스 가지고오기
                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                  // 2. 컬렉션 참조 만들기
                  CollectionReference colRef =
                      firestore.collection('todo_data');
                  // 3. 컬렉션 참조로 특정 문서에 대한 문서참조 만들기. =>
                  DocumentReference docRef = colRef.doc(todo["id"]);
                  // 4. 삭제
                  await docRef.delete();
                  loadTodoList();
                },
                onEdit: () {});
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: todoDatas.length,
        ),
      ),
    );
  }
}
