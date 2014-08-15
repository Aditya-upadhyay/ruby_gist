class Module
  def children_classes
    all_klasses = []
    klasses = constants.collect { |c| const_get(c) }.
    select { |m| m.instance_of?(Class) }
    all_klasses += klasses
    modules = constants.collect { |c| const_get(c) }.
    select { |m| m.instance_of?(Module) }
    modules.each do |child|
      all_klasses += child.children_classes
    end
    all_klasses
  end

  def children_modules
    all_modules = [] 
    modules = constants.collect { |c| const_get(c) }.
    select { |m| m.instance_of?(Module) }
    modules.each do |child|
      all_modules << child
      all_modules += child.children_modules
    end
    all_modules
  end

  def children_methods
    all_methods = methods(false)
    (children_modules + children_classes).each do |obj|
      all_methods += obj.methods(false)
    end
    all_methods
  end
end
