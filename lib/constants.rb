# A simple class trying to solve the issue of defining constants in a ruby application.
# I have always tended to define constants I use as Hashes as follows
#   PersonTypes = {:good_guy => 1, :super_hero => 2}
# But the moment I needed to add more attributes, things Got Ugly
# PersonTypesInfo = {:good_guy => {:id => 1, :name => "Mr Good Guy"}, 
#                    :super_hero => {:id => 2, :name => "Mr Hero"}}
# So, here's a simple class that initializes constants that hold attributes
# and enable you to retreive them in different ways like getting all of them
# or oredring them by one of the attributes
# Example usage
#   H= Constants.new(:koko => {:id => 1, :name => "ahmed"}, :wawa => {:id => 2, :name => "zizi"})
#   H.descend_by_name
# Note the use of sym_id which should act as the unique identifier of a constant
#   H.find(:koko) or  H[:koko]
# Other methods that are available
#  H.all
#  H.find_by(attr, value)
#  H.find_all_by(attr, value)
#  H.ascend_by(attr)
#  H.descend_by(attr)
# You can even be cooler and use
#  H.find_by_attr value
#  H.find_all_by_attr value
#  H.ascend_by_attr
#  H.descend_by_attr
# where attr is the name of any of the attributes

class Constants
  class Constant
    def initialize(attributes)
      check_attributes(attributes)
      @attributes = attributes
      @attributes.each_pair do |k,v|
        self.instance_eval("def #{k};@attributes[:#{k}];end")
      end
      unless self.respond_to?(:sym_id)
        self.instance_eval("def sym_id;nil;end")
      end
    end

    def check_attributes(attributes)
      raise ArgumentError, "attrbiutes should be a Hash" unless attributes.is_a?(Hash)
      raise ArgumentError, "attrbiutes keys should be symbols only" if attributes.keys.find {|x| !x.is_a?(Symbol)} 
    end
  end

  def initialize(hash)
    raise ArgumentError, "hash has to be of type Hash" unless hash.is_a?(Hash)
    @constants = []
    hash.each_pair {|k,v| @constants << Constant.new(v.merge({:sym_id => k}))}
  end
  
  def all
    @constants
  end
  
  def find(sym_id)
    find_by(:sym_id, sym_id)
  end
  alias_method "[]", "find"
  
  def find_by(attr, val)
    @constants.find {|x| x.send(attr) == val}
  end
  
  def find_all_by(attr, val)
    @constants.find_all {|x| x.send(attr) == val}
  end
  
  def ascend_by(attr)
    @constants.sort {|a,b| a.send(attr) <=> b.send(attr)}
  end
  
  def descend_by(attr)
    @constants.sort {|a,b| b.send(attr) <=> a.send(attr)}
  end

  def filter_and_ascend_by(attr)
    @constants.find_all {|c| c.respond_to?(attr)}.sort {|a,b| a.send(attr) <=> b.send(attr)}
  end
  
  def filter_and_descend_by(attr)
    @constants.find_all {|c| c.respond_to?(attr)}.sort {|a,b| b.send(attr) <=> a.send(attr)}
  end
  
  def method_missing(name, *args)
    name = name.to_s
    if name =~ /(find(?:_all)?_by)_(.+)/    
      send($1, $2, *args)
    elsif name =~ /((?:filter_and_)?(?:a|de)scend_by)_(.+)/
      send($1, $2)
    else
      super
    end    
  end
end