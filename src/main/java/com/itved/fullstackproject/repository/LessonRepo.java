package com.itved.fullstackproject.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.itved.fullstackproject.entity.Lesson;

public interface LessonRepo extends JpaRepository<Lesson, Long> {

    List<Lesson> findByCourseId(Long courseId);
    
    List<Lesson> findByCourseIdOrderByPositionAsc(Long courseId);

}
