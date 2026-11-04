package com.university.controller;

import com.university.entity.Course;
import com.university.repository.CourseRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/courses")
public class CourseController {
    private final CourseRepository repository;
    public CourseController(CourseRepository repository) { this.repository = repository; }

    @PostMapping public ResponseEntity<Course> create(@RequestBody Course item) { return ResponseEntity.status(HttpStatus.CREATED).body(repository.save(item)); }
    @GetMapping public List<Course> getAll() { return repository.findAll(); }
    @GetMapping("/{id}") public ResponseEntity<Course> getById(@PathVariable Integer id) { return repository.findById(id).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build()); }
    @PutMapping("/{id}") public ResponseEntity<Course> update(@PathVariable Integer id, @RequestBody Course item) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); item.setCourseId(id); return ResponseEntity.ok(repository.save(item)); }
    @DeleteMapping("/{id}") public ResponseEntity<Void> delete(@PathVariable Integer id) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); repository.deleteById(id); return ResponseEntity.noContent().build(); }
}
