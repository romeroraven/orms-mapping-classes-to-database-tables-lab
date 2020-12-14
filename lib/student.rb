class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize (name, grade, id=nil)
    @id = id
    @name = name
    @grade = grade
  end


  def self.create_table
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade TEXT
        )
        SQL
    DB[:conn].execute(sql) 
  end
  
  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end

  def self.drop_table
    sql = <<-SQL
    drop table students;
    SQL
    DB[:conn].execute(sql) 
  end

  def save
    sql = <<-SQL
    insert into students (name,grade) values(?,?);
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT MAX(ID) AS LastID FROM students")[0][0]
  end

end
