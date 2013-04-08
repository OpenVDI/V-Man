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

  context "callbacks" do
    let(:template) { FactoryGirl.create(:template) }

    it "should remove image file after destroying template" do
      template
      File.exists?(template.image_path).should be == true
      template.destroy
      File.exists?(template.image_path).should be == false
    end

  end

end
