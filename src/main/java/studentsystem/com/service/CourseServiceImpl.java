package studentsystem.com.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentsystem.com.data.Course;
import studentsystem.com.data.Teacher;
import studentsystem.com.repositories.CourseRepository;

import java.util.List;
import java.util.Optional;

@Service
public class CourseServiceImpl implements CourseService {

    private final CourseRepository courseRepository;

    @Autowired
    public CourseServiceImpl(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    @Override
    public Course createCourse(Course course, Teacher teacher) {
        course.setTeacher(teacher); // assuming Course has a Teacher field
        return courseRepository.save(course);
    }

    @Override
    public Course updateCourse(Long id, Course updatedCourse) {
        Optional<Course> existing = courseRepository.findById(id);
        if (existing.isPresent()) {
            Course course = existing.get();
            course.setName(updatedCourse.getName());
            course.setDescription(updatedCourse.getDescription());
            // update other fields as needed
            return courseRepository.save(course);
        }
        throw new RuntimeException("Course not found");
    }

    @Override
    public void deleteCourse(Long id) {
        courseRepository.deleteById(id);
    }

    @Override
    public List<Course> findCoursesByTeacher(Teacher teacher) {
        return courseRepository.findByTeacher(teacher);
    }

    @Override
    public Optional<Course> findCourseById(Long id) {
        return courseRepository.findById(id);
    }
}
