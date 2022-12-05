// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.7;

struct Todo {
    string task;
    bool isComplete;
}

contract TodoList {
    Todo[] private lists;

   function update(uint index, string calldata task) public returns (bool) {
        Todo storage todo = lists[index];
        todo.task = task;
        return true;
    }

    function markAsComplete(uint index) public {
        Todo storage todo = lists[index];
        todo.isComplete = true;
    }

    function remove(uint index) public {
        delete lists[index];
    }

    function addTodo(string memory task) public {
        lists.push(Todo(task, false));
    }
    function getTodos() public view returns (Todo[] memory) {
        return lists;
    }
    function getTodos(uint index) public view returns (Todo memory) {
        require(index < lists.length, "index must be less than array length");
       return lists[index];
    }
}
