package com.university.controller;

import com.university.entity.Enrollment;
import com.university.entity.EnrollmentId;
import com.university.repository.EnrollmentRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/enrollments")
public class EnrollmentController {
    private final EnrollmentRepository repository;
    public EnrollmentController(EnrollmentRepository repository) { this.repository = repository; }

    @PostMapping
    public ResponseEntity<Enrollment> create(@RequestBody Enrollment item) {
        return ResponseEntity.status(HttpStatus.CREATED).body(repository.save(item));
    }
    @GetMapping
    public List<Enrollment> getAll() { return repository.findAll(); }
    @GetMapping("/{studentId}/{courseId}")
    public ResponseEntity<Enrollment> getById(@PathVariable Integer studentId, @PathVariable Integer courseId) {
        return repository.findById(new EnrollmentId(studentId, courseId)).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }
    @PutMapping("/{studentId}/{courseId}")
    public ResponseEntity<Enrollment> update(@PathVariable Integer studentId, @PathVariable Integer courseId, @RequestBody Enrollment item) {
        EnrollmentId id = new EnrollmentId(studentId, courseId);
        if (!repository.existsById(id)) return ResponseEntity.notFound().build();
        item.setStudentId(studentId);
        item.setCourseId(courseId);
        return ResponseEntity.ok(repository.save(item));
    }
    @DeleteMapping("/{studentId}/{courseId}")
    public ResponseEntity<Void> delete(@PathVariable Integer studentId, @PathVariable Integer courseId) {
        EnrollmentId id = new EnrollmentId(studentId, courseId);
        if (!repository.existsById(id)) return ResponseEntity.notFound().build();
        repository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
