# taskflow

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Alcance de TaskFlow

**Problema:** necesito organizar las actividades del curso de Flutter y saber cuáles faltan por entregar.

**Usuario objetivo:** estudiante de séptimo nivel de Tecnologías de la Información que planifica sus entregas semanales.

### Historias de usuario y criterios de aceptación

1. Como estudiante, quiero listar mis tareas para ver qué debo hacer.
   - Criterio: la lista muestra título, prioridad y estado de cada tarea.
2. Como estudiante, quiero abrir una tarea para leer su descripción.
   - Criterio: al tocar una tarjeta aparece el detalle de la tarea elegida.
3. Como estudiante, quiero crear una tarea para registrar un pendiente.
   - Criterio: el formulario guarda una tarea válida y la lista la muestra.
4. Como estudiante, quiero editar una tarea para corregir sus datos.
   - Criterio: los cambios guardados aparecen en la lista y en el detalle.
5. Como estudiante, quiero eliminar una tarea terminada para limpiar la lista.
   - Criterio: después de confirmar, la tarea desaparece de la lista.

### Modelo de datos

**Task:**
- `id`: entero único
- `title`: texto
- `description`: texto
- `priority`: Alta, Media o Baja
- `isCompleted`: verdadero o falso
- `userId`: entero que identifica al usuario de prueba

### Tareas de ejemplo actuales

| id | Título | Prioridad | Estado |
|----|--------|-----------|--------|
| 1 | Instalar Flutter | Alta | Completada |
| 2 | Agregar estado a TaskFlow | Alta | Completada |
| 3 | Crear listado de tareas | Media | Completada |
| 4 | Navegar al detalle | Media | Completada |
| 5 | Especificar TaskFlow | Alta | Pendiente |

### Pantallas previstas

- **Lista:** tarjetas de tareas y acción para crear.
- **Detalle:** información completa y futuras acciones de editar o eliminar.
- **Formulario:** campos de título, descripción y prioridad.

### Requisitos no funcionales

- La navegación debe tener textos comprensibles.
- Un id inexistente debe mostrar un mensaje en vez de cerrar la app.

### Contrato de API que necesitaremos

| Método | Ruta | Operación |
|--------|------|-----------|
| GET | /tasks | Listar tareas |
| GET | /tasks/:id | Consultar detalle |
| POST | /tasks | Crear tarea |
| PATCH | /tasks/:id | Actualizar tarea |
| DELETE | /tasks/:id | Eliminar tarea |

La API concreta se elegirá después. Estas rutas son requisitos, no direcciones de un servidor ya conectado.


## API de tareas

TaskFlow obtiene sus tareas de JSONPlaceholder, una API pública de prueba, usando el cliente HTTP Dio.

- **URL exacta:** `https://jsonplaceholder.typicode.com/todos?userId=2`
- **Método:** `GET`
- **Parámetro `userId`:** filtra las tareas de un solo usuario. En el código se define en la constante `TaskApiService.userId`, y el valor elegido es `2`.

### Campos que llegan de la API

| Campo de la API | Campo en `Task` | Nota |
|---|---|---|
| `id` | `id` | Se usa como número entero. |
| `title` | `title` | Texto de la tarea. |
| `completed` | `isCompleted` | `fromJson` acepta `completed` o `isCompleted`. |
| `userId` | `userId` | Corresponde al usuario consultado. |

### Valores que TaskFlow completa por defecto

La API no entrega `description` ni `priority`, por lo que `Task.fromJson` usa estos valores de ejemplo cuando faltan:

- `description`: `Sin descripción (API)`
- `priority`: `Sin prioridad (API)`

Estos valores no vienen del servidor.

### Marcar una tarea sigue siendo local

Al marcar una tarea como completada, el cambio solo se guarda en una copia en memoria (`RemoteTaskRepository.save`). JSONPlaceholder no guarda cambios permanentes, así que al reiniciar la app la tarea vuelve a su estado original. Las operaciones remotas de escritura se estudiarán en sesiones posteriores.

### Recorrido de los datos

`main.dart` → `TasksViewModel.loadTasks()` → `RemoteTaskRepository.getTasks()` → `TaskApiService.getTasks()` → Dio hace `GET` → `Task.fromJson()` → `notifyListeners()` → la pantalla muestra la lista.