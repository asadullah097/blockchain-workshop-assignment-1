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

//single inheritance
contract Student is Person {
    uint8 public marks = 78;
    string public course = "Blockchain Course";
    
    //get details
    function getDetails() public view returns(string memory,uint8,string memory,uint8,string memory){
        return (name,age,city,marks,course);
    }
}
contract caller1 {
    Student std = new Student();

    // Defining function to call setValue and getValue functions
    function testSingleInheritance() public {
        return std.setDetails();
    }
}