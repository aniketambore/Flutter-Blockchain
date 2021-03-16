pragma solidity ^0.5.9 ;

contract Todo{

    uint public taskCount ;
    struct Task{
        uint id ;
        string heading;
        string description;
    }

    Task[] public tasks ;


    constructor() public{
        taskCount = 0 ;
    }

    function createTask(string memory head,string memory desc) public{
        tasks.push(Task(taskCount++,head,desc)) ;
    }

    function updateTask(uint id,string memory head,string memory desc) public{
        tasks[id].heading = head ;
        tasks[id].description = desc ;
    }

    function deleteTask(uint id) public{
        delete tasks[id];
    }

}