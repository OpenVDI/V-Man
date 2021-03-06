require 'spec_helper'

describe "template management" do

  describe "guest" do

    it "shouldn't be able to access templates" do
      visit templates_path
      page.current_url.should match(new_user_session_url)
    end

  end

  describe "user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:template) { FactoryGirl.create(:template) }

    it "should be able to read templates" do
      template
      login_as user
      visit templates_path
      page.should have_content(template.name)
    end

    it "shouldn't be able to write templates" do
      template
      login_as user
      visit templates_path
      page.should_not have_selector "a[href='#{edit_template_path(template)}']", text: "Edit"
      page.should_not have_selector "a[href='#{template_path(template)}'][data-method='delete']", text: "Destroy"
      visit edit_template_path(template)
      page.status_code.should be == 403
    end

    after(:each) do
      user.destroy
      template.destroy
    end

  end

  describe "admin" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:template) { FactoryGirl.create(:template) }

    it "should be able to create template" do
      login_as admin
      visit templates_path
      click_link 'New Template'
      fill_in 'Name', with: 'foo archlinux'
      fill_in 'Description', with: 'this is going to be my visionary archlinux template'
      attach_file 'Image', Rails.root.join('images', 'test.qcow2')
      expect { click_button 'Create Template' }.to change(Template, :count).by(1)
      _template = Template.last
      File.exists?(_template.image_path).should be == true
      _template.destroy
    end

    it "should be able to destroy template" do
      login_as admin
      template
      visit templates_path
      expect { find(:css, "a[href='#{template_path(template)}'][data-method='delete']").click }.to change(Template, :count).by(-1)
    end

    it "should be able to edit template" do
      login_as admin
      template
      visit templates_path
      find(:css, "a[href='#{edit_template_path(template)}']").click
      new_name = 'foo bar baz template'
      fill_in 'Name', with: new_name
      click_button 'Update Template'
      template.reload
      template.name.should be == new_name
    end

    after(:each) do
      admin.destroy
      template.destroy
    end

  end

end
