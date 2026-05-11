package com.itved.fullstackproject.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.itved.fullstackproject.dto.LessonWrapper;
import com.itved.fullstackproject.entity.Course;
import com.itved.fullstackproject.entity.Lesson;
import com.itved.fullstackproject.repository.CourseRepository;
import com.itved.fullstackproject.repository.LessonRepo;

@Controller
@RequestMapping("/admin")
public class AdminController {

    // ✅ FIX: Added missing repository
    @Autowired
    private CourseRepository repo;

    @Autowired
    private LessonRepo lessonRepo;

    // ==========================
    // DASHBOARD
    // ==========================
    @GetMapping("/dashboard")
    public String dashboard() {
        return "admin-dashboard";
    }

    // ==========================
    // ADD COURSE
    // ==========================
    @GetMapping("/add-course")
    public String addCourseForm() {
        return "add-course";
    }

    @PostMapping("/save-course")
    public String saveCourse(@RequestParam String title,
                             @RequestParam String description,
                             @RequestParam Double price,
                             @RequestParam String videoUrl,
                             @RequestParam String instructor,
                             @RequestParam String duration,
                             @RequestParam("image") MultipartFile file) {

        try {
            String uploadDir = "uploads/";
            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();

            Path path = Paths.get(uploadDir + fileName);
            Files.createDirectories(path.getParent());
            Files.write(path, file.getBytes());

            Course c = new Course();
            c.setTitle(title);
            c.setDescription(description);
            c.setPrice(price);
            c.setVideoUrl(videoUrl);
            c.setInstructor(instructor);
            c.setDuration(duration);
            c.setImageUrl("/uploads/" + fileName);

            repo.save(c);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/admin/courses";
    }

    // ==========================
    // VIEW COURSES
    // ==========================
    @GetMapping("/courses")
    public String viewCourses(Model model) {
        model.addAttribute("courses", repo.findAll());
        return "admin-courses";
    }

    // ==========================
    // DELETE COURSE
    // ==========================
    @GetMapping("/delete/{id}")
    public String deleteCourse(@PathVariable Long id) {
        repo.deleteById(id);
        return "redirect:/admin/courses";
    }

    // ==========================
    // EDIT COURSE
    // ==========================
    @GetMapping("/edit/{id}")
    public String editCourse(@PathVariable Long id, Model model) {
        Course course = repo.findById(id).orElse(null);
        model.addAttribute("course", course);
        return "edit-course";
    }

    // ==========================
    // UPDATE COURSE
    // ==========================
    @PostMapping("/update-course")
    public String updateCourse(@RequestParam Long id,
                               @RequestParam String title,
                               @RequestParam String description,
                               @RequestParam Double price,
                               @RequestParam String videoUrl,
                               @RequestParam String instructor,
                               @RequestParam String duration,
                               @RequestParam("imageFile") MultipartFile file) {

        Course c = repo.findById(id).orElse(null);

        if (c != null) {
            c.setTitle(title);
            c.setDescription(description);
            c.setPrice(price);

            // ✅ FIX: Convert YouTube URL properly
            if (videoUrl != null && !videoUrl.isEmpty()) {

                if (videoUrl.contains("watch?v=")) {
                    videoUrl = videoUrl.replace("watch?v=", "embed/");
                } 
                else if (videoUrl.contains("youtu.be/")) {
                    String videoId = videoUrl.split("youtu.be/")[1].split("\\?")[0];
                    videoUrl = "https://www.youtube.com/embed/" + videoId;
                } 
                else if (videoUrl.contains("youtube.com/live/")) {
                    videoUrl = videoUrl.replace("youtube.com/live/", "youtube.com/embed/");
                }

                c.setVideoUrl(videoUrl);
            }

            c.setInstructor(instructor);
            c.setDuration(duration);

            // IMAGE UPDATE
            if (file != null && !file.isEmpty()) {
                try {
                    String uploadDir = "uploads/";
                    String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();

                    Path path = Paths.get(uploadDir + fileName);
                    Files.createDirectories(path.getParent());
                    Files.write(path, file.getBytes());

                    c.setImageUrl("/uploads/" + fileName);

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            repo.save(c);
        }

        return "redirect:/admin/courses";
    }
    // ==========================
    // ADD LESSON
    // ==========================
    @GetMapping("/add-lesson")
    public String showAddLesson(Model model) {
        model.addAttribute("lesson", new Lesson());
        model.addAttribute("courses", repo.findAll());
        return "add-lesson";
    }

    @PostMapping("/save-lesson")
    public String saveLesson(@ModelAttribute Lesson lesson) {

        String url = lesson.getVideoUrl();
        List<Lesson> lessons = lessonRepo.findByCourseId(lesson.getCourseId());
        lesson.setPosition(lessons.size() + 1);

        // ✅ Fix YouTube URL
        if (url != null) {
            if (url.contains("watch?v=")) {
                url = url.replace("watch?v=", "embed/");
            } else if (url.contains("youtu.be/")) {
                url = url.replace("youtu.be/", "www.youtube.com/embed/");
            } else if (url.contains("youtube.com/live/")) {
                url = url.replace("youtube.com/live/", "youtube.com/embed/");
            }
        }

        lesson.setVideoUrl(url);

        lessonRepo.save(lesson);

        return "redirect:/admin/dashboard";
    }

    // ==========================
    // EDIT LESSON
    // ==========================
    @GetMapping("/edit-lesson/{id}")
    public String editLesson(@PathVariable Long id, Model model) {
        Lesson lesson = lessonRepo.findById(id).orElse(null);
        model.addAttribute("lesson", lesson);
        return "edit-lesson";
    }

    // ==========================
    // UPDATE LESSON
    // ==========================
    @PostMapping("/update-lesson")
    public String updateLesson(@ModelAttribute Lesson lesson) {

        String url = lesson.getVideoUrl();

        if (url != null) {
            if (url.contains("watch?v=")) {
                url = url.replace("watch?v=", "embed/");
            } else if (url.contains("youtu.be/")) {
                url = url.replace("youtu.be/", "www.youtube.com/embed/");
            }
        }

        lesson.setVideoUrl(url);

        lessonRepo.save(lesson);

        return "redirect:/admin/dashboard";
    }
    
    @GetMapping("/edit-lessons/{courseId}")
    public String editLessons(@PathVariable Long courseId, Model model) {

        List<Lesson> lessons = lessonRepo.findByCourseIdOrderByPositionAsc(courseId); // ✅ FIX

        model.addAttribute("lessons", lessons);
        model.addAttribute("courseId", courseId);

        return "edit-lessons";
    }
    @PostMapping("/update-lessons")
    public String updateLessons(@ModelAttribute LessonWrapper wrapper,
                                @RequestParam Long courseId) {

        // ✅ FIX: null check
        if (wrapper == null || wrapper.getLessons() == null) {
            return "redirect:/admin/edit-lessons/" + courseId;
        }

        for (Lesson lesson : wrapper.getLessons()) {

            String url = lesson.getVideoUrl();

            if (url != null) {
                if (url.contains("watch?v=")) {
                    url = url.replace("watch?v=", "embed/");
                } else if (url.contains("youtu.be/")) {
                    url = url.replace("youtu.be/", "www.youtube.com/embed/");
                }
            }

            lesson.setVideoUrl(url);

            lessonRepo.save(lesson);
        }

        return "redirect:/admin/edit-lessons/" + courseId;
    }
    @PostMapping("/delete-lesson")
    public String deleteLesson(@RequestParam Long lessonId,
                               @RequestParam Long courseId) {

        lessonRepo.deleteById(lessonId);

        return "redirect:/admin/edit-lessons/" + courseId;
    }
    @PostMapping("/move-up")
    public String moveUp(@RequestParam Long lessonId) {

        Lesson current = lessonRepo.findById(lessonId).orElse(null);

        List<Lesson> lessons = lessonRepo
            .findByCourseIdOrderByPositionAsc(current.getCourseId());

        for (int i = 1; i < lessons.size(); i++) {
            if (lessons.get(i).getId().equals(lessonId)) {

                Lesson prev = lessons.get(i - 1);

                int temp = current.getPosition();
                current.setPosition(prev.getPosition());
                prev.setPosition(temp);

                lessonRepo.save(prev);
                lessonRepo.save(current);
                break;
            }
        }

        return "redirect:/admin/edit-lessons/" + current.getCourseId();
    }
    @PostMapping("/move-down")
    public String moveDown(@RequestParam Long lessonId) {

        Lesson current = lessonRepo.findById(lessonId).orElse(null);

        List<Lesson> lessons = lessonRepo
            .findByCourseIdOrderByPositionAsc(current.getCourseId());

        for (int i = 0; i < lessons.size() - 1; i++) {
            if (lessons.get(i).getId().equals(lessonId)) {

                Lesson next = lessons.get(i + 1);

                int temp = current.getPosition();
                current.setPosition(next.getPosition());
                next.setPosition(temp);

                lessonRepo.save(next);
                lessonRepo.save(current);
                break;
            }
        }

        return "redirect:/admin/edit-lessons/" + current.getCourseId();
    }
    @GetMapping("/fix-positions/{courseId}")
    public String fixPositions(@PathVariable Long courseId) {

        List<Lesson> lessons = lessonRepo.findByCourseIdOrderByPositionAsc(courseId);

        int pos = 1;

        for (Lesson l : lessons) {
            l.setPosition(pos++);
            lessonRepo.save(l);
        }

        return "redirect:/admin/edit-lessons/" + courseId;
    }
    
    @PostMapping("/update-order")
    @ResponseBody
    public String updateOrder(@RequestBody List<Lesson> updatedLessons) {

        for (Lesson l : updatedLessons) {

            Lesson lesson = lessonRepo.findById(l.getId()).orElse(null);

            if (lesson != null) {
                lesson.setPosition(l.getPosition());
                lessonRepo.save(lesson);
            }
        }

        return "success";
    }
}