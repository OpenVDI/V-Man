require 'spec_helper'

describe Template do

  context "validation" do
    let(:template) { FactoryGirl.build(:template) }

    it "should require name" do
      template.name = ''
      template.valid?.should be == false
      template.errors.messages.should include(:name)
    end

  end

end
