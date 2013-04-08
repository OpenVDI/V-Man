class Template < ActiveRecord::Base
  attr_accessible :description, :name

  after_destroy :remove_image

  validates :name, :presence => true, :length => { :minimum => 3 }

  def image_path
    Rails.root.join('images', "#{id}.qcow2")
  end

  private

  def remove_image
    FileUtils.rm(image_path)
  end

end
