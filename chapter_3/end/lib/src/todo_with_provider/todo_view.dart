import 'package:flutter/material.dart';
import 'package:todo/src/controllers/todo_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/src/widgets/todo_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:todo/src/widgets/widgets.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  static const routeName = '/todos';

  @override
  Widget build(BuildContext context) {
    final TodoController controller = context.read();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.symmetric(vertical: 30),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 550),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: TodoTextField(
                  onSubmitted: (value) {
                    controller.createTodo(Todo(
                      id: controller.todos.length + 1,
                      task: value,
                    ));
                  },
                ),
              ),
              Builder(
                builder: (BuildContext context) {
                  final todos = context.select((TodoController m) => m.todos);

                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return TodoListTile(
                        todo: todo,
                        onToggleComplete: (bool? value) {
                          controller.update(todo.copyWith(complete: value));
                        },
                        onDelete: () {
                          controller.deleteTodo(todo);
                        },
                      );
                    },
                    itemCount: todos.length,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}