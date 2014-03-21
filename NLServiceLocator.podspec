Pod::Spec.new do |s|
  s.name         = "NLServiceLocator"
  s.version      = "1.0.0"
  s.summary      = "Implementation of Service Locator design pattern for Objective C. "

  s.description  = <<-DESC
                   A longer description of NLServiceLocator in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.license      = 'MIT'

  s.author             = { "Nikita Leonov" => "nikita.leonov@gmail.com" }
  s.social_media_url = "http://twitter.com/leonovco"

  s.source       = { :git => "https://github.com/nikita-leonov/NLServiceLocator.git", :tag => "1.0.0" }

  s.source_files  = 'ServiceLocator/*.{h,m}'

  s.framework  = 'Foundation'

  s.requires_arc = true
end
