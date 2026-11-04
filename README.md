# University Database Spring Boot Backend

A small REST API built with Java, Spring Boot, Spring Data JPA, and MySQL. It uses the existing `university` database created by `../university_database.sql`. It never creates a new database.

## Project structure

```
src/main/java/com/university/
  entity/       # Java classes mapped to the six SQL tables
  repository/   # Spring Data JPA database access interfaces
  controller/   # REST API endpoints
  UniversityApplication.java
src/main/resources/application.properties
```

`Teaches` and `Enrollment` each have two-column primary keys. Their `Id` classes tell JPA which two fields form the key.

## Before running

1. Start your local MySQL server.
2. Make sure the existing `university` database and its six tables are present. If needed, first run `../university_database.sql` in MySQL Workbench.
3. Install Java 17 or newer and Maven.
4. Set your MySQL password as an environment variable. In PowerShell:

```powershell
$env:DB_USERNAME = "root"
$env:DB_PASSWORD = "your_mysql_password"
```

If your MySQL user is not `root`, change `DB_USERNAME`. The URL is in `src/main/resources/application.properties`; edit it only if your server uses a different host or port.

## Run the application

From the `university-backend` folder:

```powershell
mvn spring-boot:run
```

When startup succeeds, the API is available at `http://localhost:8080`. `spring.jpa.hibernate.ddl-auto=none` tells Hibernate to use the existing tables without creating, dropping, or updating them.

## Endpoints

Every normal table follows this CRUD pattern:

| Resource | Create | Read all | Read one | Update | Delete |
|---|---|---|---|---|---|
| Departments | `POST /api/departments` | `GET /api/departments` | `GET /api/departments/{id}` | `PUT /api/departments/{id}` | `DELETE /api/departments/{id}` |
| Teachers | `POST /api/teachers` | `GET /api/teachers` | `GET /api/teachers/{id}` | `PUT /api/teachers/{id}` | `DELETE /api/teachers/{id}` |
| Students | `POST /api/students` | `GET /api/students` | `GET /api/students/{id}` | `PUT /api/students/{id}` | `DELETE /api/students/{id}` |
| Courses | `POST /api/courses` | `GET /api/courses` | `GET /api/courses/{id}` | `PUT /api/courses/{id}` | `DELETE /api/courses/{id}` |
| Teaches | `POST /api/teaches` | `GET /api/teaches` | `GET /api/teaches/{teacherId}/{courseId}` | `PUT /api/teaches/{teacherId}/{courseId}` | `DELETE /api/teaches/{teacherId}/{courseId}` |
| Enrollments | `POST /api/enrollments` | `GET /api/enrollments` | `GET /api/enrollments/{studentId}/{courseId}` | `PUT /api/enrollments/{studentId}/{courseId}` | `DELETE /api/enrollments/{studentId}/{courseId}` |

## Example requests and responses

### Read students

`GET http://localhost:8080/api/students/1001`

```json
{
  "studentId": 1001,
  "name": "Aarav Gupta",
  "city": "Ghaziabad",
  "admissionYear": 2022,
  "cgpa": 8.70,
  "deptId": 1
}
```

### Create a department

`POST http://localhost:8080/api/departments`

```json
{
  "deptId": 7,
  "deptName": "Physics",
  "building": "Science Block",
  "budget": 400000.00
}
```

The successful response is `201 Created` with the same department JSON.

### Update a student

`PUT http://localhost:8080/api/students/1001`

```json
{
  "name": "Aarav Gupta",
  "city": "Delhi",
  "admissionYear": 2022,
  "cgpa": 8.90,
  "deptId": 1
}
```

The ID comes from the URL, so it does not need to be in the request body.

### Create an enrollment (composite key)

`POST http://localhost:8080/api/enrollments`

```json
{
  "studentId": 1010,
  "courseId": 601,
  "marks": 84.00,
  "attendance": 88.00
}
```

The student and course must already exist because the MySQL table has foreign keys.

## Test with Postman

1. Start the app and open Postman.
2. Create a request, choose the HTTP method, and enter an endpoint URL from the table.
3. For `POST` or `PUT`, open **Body > raw**, choose **JSON**, and paste the matching example JSON.
4. Click **Send** and check the status code: `200 OK` for reads/updates, `201 Created` for creates, and `204 No Content` for deletes.
5. Use a new ID when testing `POST`, then use that same ID for `GET`, `PUT`, and `DELETE`.

For the existing assignment data, a safe first test is `GET http://localhost:8080/api/students`.

## How one API works

Look at `DepartmentController`:

1. `@RestController` makes methods return JSON. `@RequestMapping("/api/departments")` sets the base URL.
2. The constructor receives `DepartmentRepository`. Spring creates this repository automatically because it extends `JpaRepository`.
3. `getAll()` calls `repository.findAll()`. `create()` receives JSON in `@RequestBody`, calls `repository.save(...)`, and returns HTTP 201.
4. `update()` first checks that the URL ID exists, sets that ID on the object, and then saves it. `delete()` checks first and returns 404 if the row does not exist.

Try implementing another controller by copying this pattern and changing the entity, repository, URL, and ID setter. `TeachesController` and `EnrollmentController` show the one difference for a composite primary key: they build an ID object from two URL values.
