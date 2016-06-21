Pod::Spec.new do |s|

  s.name         = "FTFoldingTableView"
  s.version      = "0.0.1"
  s.summary      = "Folding cells with simple delegates, and change UI looks in a few lines of code."
  s.description  = <<-DESC
      FTFoldingTableView.
                   DESC
  s.homepage     = "https://github.com/liufengting/FTFoldingTableView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "liufengting" => "wo157121900@me.com" }
  s.social_media_url   = "http://twitter.com/liufengting"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/liufengting/FTImageViewer.git", :tag => "#{s.version}" }
  s.source_files = "FTFoldingTableView/*.{h,m}"
  s.resources = "FTFoldingTableView/*.{png}"

end