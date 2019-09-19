Pod::Spec.new do |spec|
  spec.name         = "PushNotificationSimulation"
  spec.version      = "0.0.1"
  spec.summary      = "Helper in simulating push notifications"
  spec.homepage     = "https://github.com/pwlkania/PushNotificationSimulation"
  spec.license      = "MIT"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Paweł Kania" => "pkania@pgs-soft.com" }
  spec.platform     = :ios
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/pwlkania/PushNotificationSimulation.git", :tag => "#{spec.version}" }
  spec.source_files = "Source"
end