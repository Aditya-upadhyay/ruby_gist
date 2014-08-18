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
  
  def cherrypick_methods module_name, *method_names
    include module_name
    module_name.instance_methods.each do |m|
      undef_method m unless method_names.include?(m)
    end      
  end
end
