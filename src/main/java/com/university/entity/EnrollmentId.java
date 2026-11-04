package com.university.entity;

import java.io.Serializable;
import java.util.Objects;

public class EnrollmentId implements Serializable {
    private Integer studentId;
    private Integer courseId;

    public EnrollmentId() { }
    public EnrollmentId(Integer studentId, Integer courseId) {
        this.studentId = studentId;
        this.courseId = courseId;
    }
    public Integer getStudentId() { return studentId; }
    public void setStudentId(Integer studentId) { this.studentId = studentId; }
    public Integer getCourseId() { return courseId; }
    public void setCourseId(Integer courseId) { this.courseId = courseId; }
    @Override public boolean equals(Object other) {
        if (this == other) return true;
        if (!(other instanceof EnrollmentId id)) return false;
        return Objects.equals(studentId, id.studentId) && Objects.equals(courseId, id.courseId);
    }
    @Override public int hashCode() { return Objects.hash(studentId, courseId); }
}
