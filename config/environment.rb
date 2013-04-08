# Load the rails application
require File.expand_path('../application', __FILE__)

VMan::Application.configure do
  config.supported_images = ['qcow2']
  config.image_types = {
    'qcow2' => 'application/octet-stream'
  }
end

# Initialize the rails application
VMan::Application.initialize!
