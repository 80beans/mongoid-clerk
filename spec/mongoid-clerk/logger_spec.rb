require 'spec_helper'

class MongoidDocumentWithClerk
  include Mongoid::Document
  include Clerk::Logger

  field :name
  field :address
  field :phone

  clerk_always_include :name, :address => :place

end

class InheritedMongoidDocumentWithClerk < MongoidDocumentWithClerk
end

class InheritedOverriddenMongoidDocumentWithClerk < MongoidDocumentWithClerk
  clerk_always_include :phone => :tel
end

describe MongoidDocumentWithClerk do

  context "class methods" do
    subject { MongoidDocumentWithClerk }

    it { should respond_to :default_fields }
    it { should respond_to :clerk_always_include }
  end

  context "instance methods" do
    subject { MongoidDocumentWithClerk.new }

    it { should respond_to :log }
    it { should respond_to :included_fields }
    it { should have_many :log_items }
  end

  describe ".clerk_always_include" do

    describe "dynamic Clerk::Log fields" do
      subject { Clerk::Log }

      it { should have_field :name }
      it { should have_field :place }
    end

    describe "default fields" do
      subject { MongoidDocumentWithClerk.default_fields }

      it "should contain the field mapping" do
        should == {:name => :name, :address => :place}
      end

    end

  end

  describe "#included_fields" do
    let(:document_with_clerk) { MongoidDocumentWithClerk.new(:name => 'James Bond', :address => 'Secret') }
    subject { document_with_clerk.included_fields }

    it { should == {:name => 'James Bond', :place => 'Secret'} }
  end

  describe "#log" do
    let(:document_with_clerk) { MongoidDocumentWithClerk.new(:name => 'James Bond', :address => 'Secret') }

    context "with default values" do

      it "should call Clerk::Log with the correct params" do
        document_with_clerk.log_items.should_receive(:create!).with(
          :name => 'James Bond',
          :place => 'Secret',
          :message => 'bananas',
          :level => :info
        )
      end

      after { document_with_clerk.log('bananas') }
    end

    context "with overriden status level" do

      it "should call Clerk::Log with the correct params" do
        document_with_clerk.log_items.should_receive(:create!).with(
          :name => 'James Bond',
          :place => 'Secret',
          :message => 'bananas',
          :level => :error
        )
      end

      after { document_with_clerk.log('bananas', :error) }
    end

  end

end

describe InheritedMongoidDocumentWithClerk do

  describe "inherited default fields" do
    subject { InheritedMongoidDocumentWithClerk.default_fields }

    it "should contain the field mapping" do
      should == {:name => :name, :address => :place}
    end

  end

end


describe InheritedOverriddenMongoidDocumentWithClerk do

  describe "inherited default fields" do
    subject { InheritedOverriddenMongoidDocumentWithClerk.default_fields }

    it "should contain the field mapping with additions" do
      should == {:name => :name, :address => :place, :phone => :tel}
    end

  end

end
