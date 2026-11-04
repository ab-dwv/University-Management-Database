package com.university.entity;

import java.io.Serializable;
import java.util.Objects;

public class TeachesId implements Serializable {
    private Integer teacherId;
    private Integer courseId;

    public TeachesId() { }
    public TeachesId(Integer teacherId, Integer courseId) {
        this.teacherId = teacherId;
        this.courseId = courseId;
    }
    public Integer getTeacherId() { return teacherId; }
    public void setTeacherId(Integer teacherId) { this.teacherId = teacherId; }
    public Integer getCourseId() { return courseId; }
    public void setCourseId(Integer courseId) { this.courseId = courseId; }
    @Override public boolean equals(Object other) {
        if (this == other) return true;
        if (!(other instanceof TeachesId id)) return false;
        return Objects.equals(teacherId, id.teacherId) && Objects.equals(courseId, id.courseId);
    }
    @Override public int hashCode() { return Objects.hash(teacherId, courseId); }
}
