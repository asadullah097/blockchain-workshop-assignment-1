// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

contract Person {
   string public name;
   uint8 public age;
   string public city;
   
   //set details
   function setDetails() external{
      name="Asad ullah";
      age=25;
      city="Timergara Dir lower";
   }
} 
contract Student is Person {
   uint8 public marks = 78;
   string public course = "Blockchain Course";
    
    //get details
   function getStudentDetails() public view returns(string memory,uint8,string memory,uint8,string memory){
      return (name,age,city,marks,course);
   }
}

contract Teacher is Person {
   string public professtion="Teacher";
   //get details
   function getTeacherDetails() public view returns(string memory,uint8,string memory,string memory){
      return (name,age,city,professtion);
   }
}

contract Doctor is Person {
    string public professtion="Doctor";
     function getDoctorDetails() public view returns(string memory,uint8,string memory,string memory){
      return (name,age,city,professtion);
   }
}
contract caller2 {
   // Creating object of contract Student
   Student std = new Student();

   // Creating object of contract Teacher
   Teacher teacher = new Teacher();

   // Creating object of contract Teacher
   Doctor doctor = new Doctor();

   // Defining public function 
   function testStudent() public view returns (string memory,uint8,string memory,uint8,string memory) {
     return std.getStudentDetails();
   }

   function testTeacher() public view returns(string memory,uint8,string memory,string memory) {
      return teacher.getTeacherDetails();
   }

    function testDoctor() public view returns(string memory,uint8,string memory,string memory) {
      return doctor.getDoctorDetails();
   }
}