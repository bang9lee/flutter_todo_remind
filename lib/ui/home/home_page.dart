import 'package:flutter/material.dart';
import 'package:flutter_todo_remind/ui/home/todo_item.dart';
import 'package:flutter_todo_remind/ui/home/todo_text_button.dart';

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
          // TODO 바텀시트 보여주기
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
