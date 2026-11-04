package com.university.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;

import java.math.BigDecimal;

@Entity
@Table(name = "enrollment")
@IdClass(EnrollmentId.class)
public class Enrollment {
    @Id
    private Integer studentId;
    @Id
    private Integer courseId;
    private BigDecimal marks;
    private BigDecimal attendance;

    public Enrollment() { }
    public Integer getStudentId() { return studentId; }
    public void setStudentId(Integer studentId) { this.studentId = studentId; }
    public Integer getCourseId() { return courseId; }
    public void setCourseId(Integer courseId) { this.courseId = courseId; }
    public BigDecimal getMarks() { return marks; }
    public void setMarks(BigDecimal marks) { this.marks = marks; }
    public BigDecimal getAttendance() { return attendance; }
    public void setAttendance(BigDecimal attendance) { this.attendance = attendance; }
}
