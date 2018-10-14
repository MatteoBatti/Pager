Pod::Spec.new do |s|
  s.name         = "PagerTab"
  s.version      = "0.3"

  s.summary      = "Elegant Pager View in Swift"
  s.license      = "MIT"
  s.homepage 	 = 'https://github.com/MatteoBatti/Pager'
  s.author             = { "Matteo Battistini" => "batti0011@gmail.bom" }
  s.source       = { :git => "https://github.com/MatteoBatti/Pager.git", :tag => s.version.to_s }
  s.swift_version = "4.2"

  s.ios.deployment_target = "9.0"

  s.source_files  = "Sources/**/*"
end
