require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-tecate-ar"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-tecate-ar
                   DESC
  s.homepage     = "https://github.com/github_account/react-native-tecate-ar"
  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
  s.authors      = { "Your Name" => "yourname@email.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/github_account/react-native-tecate-ar.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,swift,scnassets,xcassets}"
  s.resources = "ios/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
  s.resource_bundles = {
    "resources" => ["ios/**/*.{lproj,storyboard}"]}
  s.requires_arc = true

  s.dependency "React"
  # ...
  # s.dependency "..."
end

