package com.university.repository;

import com.university.entity.Enrollment;
import com.university.entity.EnrollmentId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EnrollmentRepository extends JpaRepository<Enrollment, EnrollmentId> { }
