require 'spec_helper'

describe User do

  context "devise" do
    let(:user) { FactoryGirl.build(:user) }

    it "should return roles in sombol" do
      user.role_symbols.each do |role|
        role.should be_kind_of(Symbol)
      end
    end

  end

end
