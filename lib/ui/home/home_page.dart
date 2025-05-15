import 'package:flutter/material.dart';
import 'package:flutter_todo_remind/ui/home/todo_item.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Color(0xFF5714E6),
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
                padding: EdgeInsets.only(left: 24, right: 24, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 할일 글자
                    Text('할일'),
                    SizedBox(height: 11),
                    // 글자 입력하는 테스트필드
                    TextField(
                      onChanged: (value) {
                        content = value;
                      },
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1F2024),
                      ),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
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
                    Spacer(),
                    // 저장 버튼
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          print(content);
                          // TODO content 파이어베이스에 저장!
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Color(0xFF5714E6),
                          ),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                        child: Text(
                          '저장',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      appBar: AppBar(
        title: Text(
          'TODO 리스트',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 1),
          child: Container(
            height: 1,
            // FF => 255
            // 불투명도 0~255
            // 0x00
            color: Color(0xFFDCDCDC),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // 위젯들 배치
            TodoItem(
              isChecked: false,
              text: '물마시기',
              onDelete: () {
                print('물마시기 삭제 처치됨');
              },
              onEdit: () {
                print('물마시기 수정 처치됨');
              },
            ),
            SizedBox(height: 20),
            TodoItem(
              isChecked: true,
              text: '프로그래밍프로그래밍프로그래밍프로그래밍',
              onDelete: () {
                print('프로그래밍 삭제 처치됨');
              },
              onEdit: () {
                print('프로그래밍 수정 처치됨');
              },
            ),
          ],
        ),
      ),
    );
  }
}
