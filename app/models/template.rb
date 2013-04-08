require 'filemagic'

class Template < ActiveRecord::Base
  attr_accessible :description, :name

  after_destroy :remove_image
  after_save :move_image

  validates :name, :presence => true, :length => { :minimum => 3 }
  validates :image, :presence => true

  def image_path
    Rails.root.join('images', "#{id}.qcow2")
  end

  def initialize(attributes = nil, options = {})
    if attributes.is_a? Hash and attributes.include?(:image)
      @image_file = attributes.delete(:image)
      @image_file = @image_file.tempfile.path if @image_file.is_a? ActionDispatch::Http::UploadedFile
    end
    super
  end

  def image
    if @image_file and check_image
      image_path
    elsif File.exists?(image_path)
      image_path
    end
  end

  def image=(image)
    @image_file = image
    @image_file = @image_file.tempfile.path if @image_file.is_a? ActionDispatch::Http::UploadedFile
  end

  private

  def remove_image
    FileUtils.rm(image_path) if File.exists?(image_path)
  end

  def move_image
    if @image_file
      FileUtils.cp(@image_file, image_path)
      @image_file = nil
    end
  end

  def check_image
    mime_type = FileMagic.new(FileMagic::MAGIC_MIME).file(@image_file).split(';')[0]
    result = VMan::Application.config.image_types.values.include?(mime_type)
    result
  end

end
