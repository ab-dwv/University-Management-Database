package com.university.controller;

import com.university.entity.Teaches;
import com.university.entity.TeachesId;
import com.university.repository.TeachesRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/teaches")
public class TeachesController {
    private final TeachesRepository repository;
    public TeachesController(TeachesRepository repository) { this.repository = repository; }

    @PostMapping
    public ResponseEntity<Teaches> create(@RequestBody Teaches item) {
        return ResponseEntity.status(HttpStatus.CREATED).body(repository.save(item));
    }
    @GetMapping
    public List<Teaches> getAll() { return repository.findAll(); }
    @GetMapping("/{teacherId}/{courseId}")
    public ResponseEntity<Teaches> getById(@PathVariable Integer teacherId, @PathVariable Integer courseId) {
        return repository.findById(new TeachesId(teacherId, courseId)).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }
    @PutMapping("/{teacherId}/{courseId}")
    public ResponseEntity<Teaches> update(@PathVariable Integer teacherId, @PathVariable Integer courseId, @RequestBody Teaches item) {
        TeachesId id = new TeachesId(teacherId, courseId);
        if (!repository.existsById(id)) return ResponseEntity.notFound().build();
        item.setTeacherId(teacherId);
        item.setCourseId(courseId);
        return ResponseEntity.ok(repository.save(item));
    }
    @DeleteMapping("/{teacherId}/{courseId}")
    public ResponseEntity<Void> delete(@PathVariable Integer teacherId, @PathVariable Integer courseId) {
        TeachesId id = new TeachesId(teacherId, courseId);
        if (!repository.existsById(id)) return ResponseEntity.notFound().build();
        repository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
