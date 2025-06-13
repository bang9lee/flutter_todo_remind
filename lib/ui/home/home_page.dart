import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_remind/data/model/todo.dart';
import 'package:flutter_todo_remind/ui/home/home_view_model.dart';
import 'package:flutter_todo_remind/ui/home/todo_item.dart';

// todolist fierstore
// => homePage  최초한번

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1) 뷰모델 관리자한테 상태 달라고 하기
    final homeState = ref.watch(homeViewModelProvider);

    // 2) 뷰모델 관리자한테 뷰모델 달라고 하기
    final HomeViewModel = ref.read(homeViewModelProvider.notifier);

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
                        onPressed: () async {
                          // TODo 글쓰기 넣을곳
                          HomeViewModel.writeTodo(content);
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
            Todo todo = homeState[index];
            // {"isDone"} : false, "content" : "hi" "id" : sdfsafsdfsfd}
            print(todo);

            return TodoItem(
                onCheckTap: () async {
                  print("여기서 체크변경");
                  HomeViewModel.updateTodo(todo);
                },
                isChecked: todo.isDone,
                text: todo.content,
                onDelete: () async {
                  HomeViewModel.deleteTodo(todo);
                },
                onEdit: () {});
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: homeState.length,
        ),
      ),
    );
  }
}
