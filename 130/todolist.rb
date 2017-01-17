class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    raise TypeError, 'can only add Todo objects' unless todo.instance_of? Todo
    todos << todo
  end
  alias_method :<<, :add
  
  def size
    todos.size
  end
  
  def first
    todos.first
  end
  
  def last
    todos.last
  end

  def item_at(idx)
    todos.fetch(idx)
  end
  
  def mark_done_at(idx)
    item_at(idx).done!
  end
  
  def mark_undone_at(idx)
    item_at(idx).undone!
  end

  def shift
    todos.shift
  end
  
  def pop
    todos.pop
  end

  def remove_at(idx)
    todos.delete(item_at(idx))
  end

  def to_s
    text = "---- #{title} ----\n"
    todos.each { |todo| text << (todo.to_s) + "\n" }
    text
  end
  
  def to_a
    todos
  end

  def done?
    todos.all? { |todo| todo.done? }
  end

  def done!
    todos.each_index do |idx|
      mark_done_at(idx)
    end
  end

  def each
    counter = 0
    while counter < todos.size do
      yield(todos[counter])
      counter += 1
    end
    self
  end

  def select
    counter = 0
    new_list = TodoList.new(title)
    
    while counter < size
      if yield(item_at(counter))
        new_list.add(item_at(counter))
      end
      counter += 1
    end
    
    new_list
  end

  def find_by_title(title_string)
    each do |todo|
      return todo if todo.title == title_string
    end
  end

  def all_done
    select { |todo| todo.done? }
  end
  
  def all_not_done
    select { |todo| !todo.done? }
  end
  
  def mark_done(title_string)
    find_by_title(title_string).done!
  end
  
  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end

  private
  attr_accessor :todos

end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

todo1.done!

puts list

list.mark_done("Go to gym")

puts list