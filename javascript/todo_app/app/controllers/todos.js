
var Todos = function () {
  this.respondsWith = ['html', 'json', 'xml', 'js', 'txt'];

  this.index = function (req, resp, params) {
    var self = this;
    geddy.model.adapter.Todo.all(function(err, todos) {
      self.respond({params: params, todos: todos});
    });
  };

  this.add = function (req, resp, params) {
    this.respond({params: params});
  };

  this.create = function (req, resp, params) {
    var self = this;
    var todo = geddy.model.Todo.create({
      title: params.title,
      id: geddy.string.uuid(10),
      status: 'open'
    });
    
    todo.save(function(err, data) {
      if (err) {
        params.error = err;
        self.transfer('add');
      }
      else {
        self.redirect({controller: self.name});
      }
    });
  };

  this.show = function (req, resp, params) {
    this.respond({params: params});
  };

  this.edit = function (req, resp, params) {
    var self = this;
    geddy.model.Todo.load(params.id, function(err, todo) {
      self.respond({params: params, todo: todo});
    })
  };

  this.update = function (req, resp, params) {
    var self = this;
    geddy.model.adapter.Todo.load(params.id, function(err, todo) {
      todo.status = params.status;
      todo.title = params.title;
      todo.save(function(err, data) {
        if (err) {
          params.error = err;
          self.transfer('edit');
        }
        else {
          self.redirect({controller: self.name});
        }
      });
    });
  };

  this.remove = function (req, resp, params) {
    var self = this;
    geddy.model.adapter.Todo.remove(params.id, function(err) {
      if (err) {
        params.errors = err;
        self.transfer('edit');
      }
      else {
        self.redirect({controller: self.name});
      }
    })
  };

};

exports.Todos = Todos;

