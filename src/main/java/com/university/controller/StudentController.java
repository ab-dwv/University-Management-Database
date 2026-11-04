package com.university.controller;

import com.university.entity.Student;
import com.university.repository.StudentRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/students")
public class StudentController {
    private final StudentRepository repository;
    public StudentController(StudentRepository repository) { this.repository = repository; }

    @PostMapping public ResponseEntity<Student> create(@RequestBody Student item) { return ResponseEntity.status(HttpStatus.CREATED).body(repository.save(item)); }
    @GetMapping public List<Student> getAll() { return repository.findAll(); }
    @GetMapping("/{id}") public ResponseEntity<Student> getById(@PathVariable Integer id) { return repository.findById(id).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build()); }
    @PutMapping("/{id}") public ResponseEntity<Student> update(@PathVariable Integer id, @RequestBody Student item) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); item.setStudentId(id); return ResponseEntity.ok(repository.save(item)); }
    @DeleteMapping("/{id}") public ResponseEntity<Void> delete(@PathVariable Integer id) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); repository.deleteById(id); return ResponseEntity.noContent().build(); }
}
