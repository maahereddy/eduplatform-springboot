package com.itved.fullstackproject.dto;

import java.util.List;
import com.itved.fullstackproject.entity.Lesson;

public class LessonWrapper {

    private List<Lesson> lessons;

    public List<Lesson> getLessons() {
        return lessons;
    }

    public void setLessons(List<Lesson> lessons) {
        this.lessons = lessons;
    }
}
