package com.university.controller;

import com.university.entity.Teacher;
import com.university.repository.TeacherRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/teachers")
public class TeacherController {
    private final TeacherRepository repository;
    public TeacherController(TeacherRepository repository) { this.repository = repository; }

    @PostMapping public ResponseEntity<Teacher> create(@RequestBody Teacher item) { return ResponseEntity.status(HttpStatus.CREATED).body(repository.save(item)); }
    @GetMapping public List<Teacher> getAll() { return repository.findAll(); }
    @GetMapping("/{id}") public ResponseEntity<Teacher> getById(@PathVariable Integer id) { return repository.findById(id).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build()); }
    @PutMapping("/{id}") public ResponseEntity<Teacher> update(@PathVariable Integer id, @RequestBody Teacher item) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); item.setTeacherId(id); return ResponseEntity.ok(repository.save(item)); }
    @DeleteMapping("/{id}") public ResponseEntity<Void> delete(@PathVariable Integer id) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); repository.deleteById(id); return ResponseEntity.noContent().build(); }
}
