import '../domain/task.dart';
import 'task_repository.dart';

class LocalTaskRepository implements TaskRepository {
  final List<Task> _tasks = [
    const Task(
      id: 1,
      title: 'Instalar Flutter',
      description: 'Configurar SDK, Android y el celular',
      priority: 'Alta',
      isCompleted: true,
      userId: 1,
    ),
    const Task(
      id: 2,
      title: 'Agregar estado a TaskFlow',
      description: 'Usar setState en los botones',
      priority: 'Alta',
      isCompleted: true,
      userId: 1,
    ),
    const Task(
      id: 3,
      title: 'Crear listado de tareas',
      description: 'Usar ListView.builder y TaskCard',
      priority: 'Media',
      isCompleted: true,
      userId: 1,
    ),
    const Task(
      id: 4,
      title: 'Navegar al detalle',
      description: 'Configurar go_router con rutas por id',
      priority: 'Media',
      isCompleted: true,
      userId: 1,
    ),
    const Task(
      id: 5,
      title: 'Especificar TaskFlow',
      description: 'Escribir historias de usuario y el modelo en el README',
      priority: 'Alta',
      isCompleted: false,
      userId: 1,
    ),
  ];

  @override
  List<Task> getTasks() => List.unmodifiable(_tasks);

  @override
  void save(Task task) {
    final index = _tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) return;
    _tasks[index] = task;
  }
}
