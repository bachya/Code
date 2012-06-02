
var Todo = function () {
  this.defineProperties({
    title: {type: 'string', required: true},
    id: {type: 'string', required: true},
    status: {type: 'string', required: true}
  });
  
  this.validatesPresent('title');
  this.validatesLength('title', {min: 5});
  this.validatesWithFunction('status', function(status) {
    return status === 'open' || status === 'done';
  });
};

/*
// Can also define them on the prototype
Todo.prototype.someOtherMethod = function () {
  // Do some other stuff
};
// Can also define static methods and properties
Todo.someStaticMethod = function () {
  // Do some other stuff
};
Todo.someStaticProperty = 'YYZ';
*/

Todo = geddy.model.register('Todo', Todo);

