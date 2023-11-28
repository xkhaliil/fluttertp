package net.ahmed.universitymanagement.web;

import net.ahmed.universitymanagement.entities.Class;
import net.ahmed.universitymanagement.entities.Student;
import net.ahmed.universitymanagement.repositories.ClassRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1")
public class ClassRestController {
    private final ClassRepository classRepository;

    public ClassRestController(ClassRepository classRepository) {
        this.classRepository = classRepository;
    }

    @GetMapping("/classes")
    public List<Class> getAllClasses() {
        return classRepository.findAll();
    }

    @GetMapping("/classes/{uuid}")
    public Class getClassById(@PathVariable("uuid") String uuid) {
        if (classRepository.findById(uuid).isPresent()) {
            return classRepository.findById(uuid).get();
        } else {
            return null;
        }
    }


    @PostMapping(value = "/classes/create", consumes = "application/json", produces = "application/json")
    public Class createClass(@RequestBody Class newClass) {
        Class classe = Class.builder()
                .name(newClass.getName())
                .numberOfStudents(newClass.getNumberOfStudents())
                .departmentSpace(newClass.getDepartmentSpace()).build();
        return classRepository.save(classe);
    }
    /*@PostMapping(value = "/students/create", consumes = "application/json", produces = "application/json")
    public Student createStudent(@RequestBody Student newStudent) {
        Student student = Student.builder()
                .firstName(newStudent.getFirstName())
                .lastName(newStudent.getLastName())
                .dateOfBirth(newStudent.getDateOfBirth())
                .classRoom(newStudent.getClassRoom())
                .build();
        return studentRepository.save(student);
    }*/
    /*@PostMapping("/classes/create")
    public Class createClass(@RequestBody Class newClass) {

        return classRepository.save(newClass);
    }*/

    @PutMapping("/classes/{uuid}")
    public Class updateClass(@PathVariable("uuid") String uuid, @RequestBody Class newClass) {
        if (classRepository.findById(uuid).isPresent()) {
            Class existingClass = classRepository.findById(uuid).get();
            existingClass.setName(newClass.getName());
            existingClass.setDepartmentSpace(newClass.getDepartmentSpace());
            existingClass.setStudents(newClass.getStudents());
            return classRepository.save(existingClass);
        } else {
            return null;
        }
    }

    @DeleteMapping("/classes/{uuid}")
    public String deleteClass(@PathVariable("uuid") String uuid) {
        if (classRepository.findById(uuid).isPresent()) {
            classRepository.deleteById(uuid);
            return "Class deleted successfully";
        } else {
            return null;
        }
    }

    @GetMapping("/classes/{uuid}/students")
    public List<Student> getStudentsByClassId(@PathVariable("uuid") String uuid) {
        if (classRepository.findById(uuid).isPresent()) {
            Class existingClass = classRepository.findById(uuid).get();
            return existingClass.getStudents();
        } else {
            return null;
        }
    }
}
