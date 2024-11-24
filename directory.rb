class Directory
  attr_accessor :name, :children
  def initialize(name)
    @name = name
    @children = {}
  end

  def add(directory)
    @children[directory.name] = directory
  end

  def remove(directory_name)
    @children.delete(directory_name)
  end

  def list(indent = 0)
    puts @name
    indent+=1
    for child in @children.values.sort_by{|child| child.name} do
      indent.times{print '   '}
      child.list(indent)
    end
  end
end

class DirectoryTree
  attr_accessor :root
  def initialize()
    @root = Directory.new('')
  end
  def add(path_name)
    path_name_arr = path_name.split('/')
    new_directory_name = path_name_arr[-1]
    new_directory = Directory.new(new_directory_name)
    if(path_name_arr.length == 1)
      @root.add(new_directory)
    else
      parent = path_name_arr[0..path_name_arr.length-2 ]
      found_parent = search(parent.join('/'))
      found_parent.add(new_directory)
    end
  end

  def add_directory(directory)
    @root.add(directory)
  end

  def move(from, to)
    found_from = search(from)
    found_to = search(to)
    found_to.add(found_from)
    delete(from)
  end
  def delete(directory_path)
    path_name_arr = directory_path.split('/')
    delete_directory_name = path_name_arr[-1]
    if(path_name_arr.length == 1)
      @root.remove(delete_directory_name)
    else
      parent = path_name_arr[0..path_name_arr.length-2 ]
      found_parent = search(parent.join('/'))
      if(found_parent)
        found_parent.remove(delete_directory_name)
      else
        puts "Cannot delete #{directory_path} - #{parent.join('/')} does not exist"
      end
    end

  end

  def search(directory_path)
    path_name_arr = directory_path.split('/')
    found = true
    currentDirectory = @root
    for directory_name in path_name_arr do
      foundDirectory = currentDirectory.children[directory_name]
      if(foundDirectory)
        currentDirectory = foundDirectory
      else
        found = false
      end
    end
    found ? currentDirectory: nil
  end

  def list()
    @root.list(-1)
  end
end

@directory1 = DirectoryTree.new()
# my_directory.add('fruits')
# my_directory.add('vegetables')
# my_directory.add('grains')
# my_directory.add('fruits/apples')
# my_directory.add('fruits/apples/fuji')
# my_directory.list
# my_directory.add('grains/squash')
# my_directory.move('grains/squash', 'vegetables')
# my_directory.add('foods')
# my_directory.move('grains', 'foods')
# my_directory.move('fruits', 'foods')
# my_directory.move('vegetables', 'foods')
# my_directory.list
# my_directory.delete('fruits/apples')
# my_directory.delete('foods/fruits/apples')
# my_directory.list

def execute_command(line)
  args = line.split(' ')
  params = args[1..-1]
  command = args[0]
  case command
  when 'LIST'
    puts 'LIST'
    @directory1.list()
  when 'CREATE'
    puts command + ' ' + params.join(' ')
    
    @directory1.add(*params)
  when 'MOVE'
    puts command + ' ' + params.join(' ')
    @directory1.move(*params)
  when 'DELETE'
    puts command + ' ' + params.join(' ')
    @directory1.delete(*params)
  end
end

INPUT_PATH = "./input.txt"
OUTPUT_PATH = "./output.txt"

if(INPUT_PATH)
  File.open(INPUT_PATH, "r") do |f|
    f.each_line do |line|
      execute_command(line)
    end
  end
end