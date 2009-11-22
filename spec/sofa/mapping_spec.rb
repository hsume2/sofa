require 'spec_helper'

describe "Mapped Object" do
  before do
    class MappedObject
      include Sofa::Mapping

      maps(:a => nil)
      maps(:B => :b)
      maps(:c => nil) do |c|
        c * 2
      end
    end
    @obj = MappedObject.new
    @value = mock()
  end

  it "should respond to #a" do
    @obj.should respond_to(:a)
  end

  it "should respond to #b" do
    @obj.should respond_to(:b)
  end

  it "should update @a" do
    @obj.update_with_mapping(:a => @value)
    @obj.a.should == @value
  end

  it "should update @b" do
    @obj.update_with_mapping(:B => @value)
    @obj.b.should == @value
  end

  it "should update @c" do
    @obj.update_with_mapping(:c => 1)
    @obj.c.should == 2
  end

  it "should not update @d" do
    @obj.update_with_mapping(:d => @value)
    @obj.instance_variable_get("@").should_not == @value
  end

  it "should not update keys that don't respond to :to_sym" do
    lambda {
      @obj.update_with_mapping(mock() => @value)      
    }.should_not raise_error
  end

  it "should get attributes as keys and their values as values" do
    a, b = mock, mock
    @obj.update_with_mapping(:a => a, :B => b)
    @obj.attributes.should == {:a => a, :b => b, :c => nil}
  end

  context "and another Mapped Object" do
    before do
      @other = MappedObject.new
      @obj.update_with_mapping(:a => @value)
      @other.update_with_mapping(:a => @value)
    end
    
    it "should be #eql" do
      @obj.should == @other
    end

    it "should not be #equal" do
      @obj.should_not equal(@other)
    end

    it "should not be #eql with different params" do
      @other.update_with_mapping(:B => mock())
      @obj.should_not == @other
    end

    it "should not be #eql to different class" do
      @obj.should_not == mock()
    end
  end
end
