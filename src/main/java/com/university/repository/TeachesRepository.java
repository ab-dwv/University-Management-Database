package com.university.repository;

import com.university.entity.Teaches;
import com.university.entity.TeachesId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TeachesRepository extends JpaRepository<Teaches, TeachesId> { }
