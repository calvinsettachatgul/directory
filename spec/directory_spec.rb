require_relative '../directory'

describe Directory do
  directory = Directory.new('test')
  describe '#new' do
    it 'has children array' do
      children = directory.children
      expect(children).to eq({})
    end
  end
  describe '#list' do
    xit 'prints the children' do
      
      directory.list()
    end
  end
  describe '#add' do
    it 'adds a direcorty' do
      directory = Directory.new('test')
      test_child = Directory.new('test_child')
      directory.add(test_child)
      expect(directory.children["test_child"].name).to eq("test_child")
    end
  end
  describe '#remove' do
    it 'removes a child' do
      directory = Directory.new('test')
      directory2 = Directory.new('test1')
      directory3 = Directory.new('test2')
      directory.add(directory2)
      directory.add(directory3)
      expect(directory.children["test1"].name).to eq("test1")
      expect(directory.children["test2"].name).to eq("test2")
      directory.remove('test2')
      expect(directory.children["test2"]).to eq(nil)

    end
  end
end

describe DirectoryTree do
  directoryTree = DirectoryTree.new()
  describe '#new' do
    it 'has a root' do
      root = directoryTree.root
      expect(root.children).to eq({})
    end
  end
  describe '#list' do
    xit 'prints all children' do
      # directory.list()
    end
  end
  describe '#delete' do
    it 'adds a direcorty' do
      directoryTree.add('test')
      directoryTree.add('test2')
      expect(directoryTree.search('test').name).to eq("test")
      expect(directoryTree.search('test2').name).to eq("test2")
      directoryTree.delete('test2')
      expect(directoryTree.search("test2")).to eq(nil)
    end
  end
  describe '#search' do
    it 'searches a directory' do
      directoryTree.add('test')
      directoryTree.add('test2')
      directoryTree.add('test3')
      directoryTree.add('test3/test4')
      expect(directoryTree.search('test').name).to eq("test")
      expect(directoryTree.search('test2').name).to eq("test2")
      expect(directoryTree.search("test3").name).to eq("test3")
      expect(directoryTree.search("test3/test4").name).to eq("test4")

    end
  end
  describe '#move' do
    it 'moves a child' do
      directoryTree.add('test')
      directoryTree.add('test2')
      directoryTree.add('test3')
      directoryTree.add('test3/test4')
      expect(directoryTree.search('test').name).to eq("test")
      expect(directoryTree.search('test2').name).to eq("test2")
      expect(directoryTree.search("test3").name).to eq("test3")
      directoryTree.move('test3/test4', 'test2')
      expect(directoryTree.search('test3/test4')).to eq(nil)
      expect(directoryTree.search('test2/test4').name).to eq('test4')

    end
  end
end

