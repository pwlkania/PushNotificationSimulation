# swift-tools-version:5.1
#
# PushNotificationSimulation.podspec
#
# Copyright (c) 2019 Paweł Kania
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

Pod::Spec.new do |spec|
  spec.name         = "PushNotificationSimulation"
  spec.version      = "1.1.2"
  spec.summary      = "Helper in simulating push notifications"
  spec.homepage     = "https://github.com/pwlkania/PushNotificationSimulation"
  spec.license      = "MIT"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Paweł Kania" => "pkania@pgs-soft.com" }
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/pwlkania/PushNotificationSimulation.git", :tag => "#{spec.version}" }
  spec.source_files = "PushNotificationSimulation/{*.swift}"
  spec.swift_versions = ['5.0']
end
