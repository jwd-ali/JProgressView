
Pod::Spec.new do |s|
  s.name         = "JProgressView"
  s.version      = "1.0.1"
  s.summary      = "ProgressView framework"
  s.description  = <<-DESC
                  You can add elegant progress animation in your view with just 2 line of code
                   DESC
  s.homepage     = "https://github.com/jwd-ali/IOS-Portfolio"
  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
  s.authors      = { "Jawad Ali" => "L060214@gmail.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/jwd-ali/ProgressView.git", :tag => "#{s.version}" }

  s.source_files = "ProgressView/**/*.{h,m,swift}"
  s.requires_arc = true
  s.swift_version = "5.0"
  
end
