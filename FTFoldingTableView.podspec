Pod::Spec.new do |s|

  s.name         = "FTFoldingTableView"
  s.version      = "1.0.6"
  s.summary      = "Folding cells with simple delegates, and change UI looks in a few lines of code."
  s.description  = <<-DESC
      FTFoldingTableView.Folding cells with simple delegates, and change UI looks in a few lines of code. I recently developed this for future use.
                   DESC
  s.homepage     = "https://github.com/liufengting/FTFoldingTableView"
  s.screenshots  = "https://raw.githubusercontent.com/liufengting/FTFoldingTableView/master/Screenshots/Screenshots1.png","https://raw.githubusercontent.com/liufengting/FTFoldingTableView/master/Screenshots/Screenshots2.png","https://raw.githubusercontent.com/liufengting/FTFoldingTableView/master/Screenshots/Screenshots3.png","https://raw.githubusercontent.com/liufengting/FTFoldingTableView/master/Screenshots/Screenshots4.png"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "liufengting" => "wo157121900@me.com" }
  s.social_media_url   = "http://twitter.com/liufengting"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/liufengting/FTFoldingTableView.git", :tag => "#{s.version}" }
  s.source_files = "FTFoldingTableViewLib/*.{h,m}"
  s.resources = "FTFoldingTableViewLib/*.{png}"

end