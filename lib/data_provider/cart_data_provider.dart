import 'package:gymha/model/course.dart';

class CartDataProvider{
  static final List<Course> _cartCourseList = [];

  static List<Course> get cartCourseList => _cartCourseList;

  static void addCourse(Course course){
    _cartCourseList.add(course);
  }

  static void addAllCourses(List<Course> courses){
    _cartCourseList.addAll(courses);
  }

  static void clearCart()
  {
    _cartCourseList.clear();
  }

  static void deleteCourse(Course course){
    _cartCourseList.remove(course);
  }
}