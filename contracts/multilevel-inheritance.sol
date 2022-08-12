// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

contract Person {
   string public name="Asad Ullah";
   uint8 public age =25;
   string public city = "Timergera Dir lower";
   function details() external view returns(string memory ,uint8 ,string memory){
    return (name,age,city);
   }
} 
contract Student is Person {
   string public professtion="Student";

   function getStudentDetails() public view returns(string memory,uint8,string memory,string memory){
      return (name,age,city,professtion);
   }
}

contract EngineeringStudent is Student{
   function getEngineeringDetails() public view returns(string memory,uint8,string memory,string memory){
      return (name,age,city,string(abi.encodePacked("Engineering", professtion)));
   }
}
contract caller3 {
   // Creating object of contract EngineeringStudent
   EngineeringStudent engrstd = new EngineeringStudent();
   
   function testStudent() public view returns(string memory,uint8,string memory,string memory) {
      return engrstd.getStudentDetails();
   }

   function testEngineeringStudent() public view returns(string memory,uint8,string memory,string memory) {
      return engrstd.getEngineeringDetails();
   }
}