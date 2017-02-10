class School
  def initialize
   @students = {} 
  end
  
  def add(name, grade)
    @students[grade] = [] unless @students[grade] 
    @students[grade] << name
  end
  
  def to_h
    @students.sort.map { |grade, names| [grade, names.sort] }.to_h
  end
  
  def grade(num)
    @students[num] || []
  end
end
