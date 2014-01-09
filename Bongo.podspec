Pod::Spec.new do |s|
  s.name         = 'Bongo'
  s.version      = '0.0.1'
  s.summary      = 'Bongo is a small barcode recognition library based on native iOS 7 API'
  s.homepage     = 'https://github.com/xNekOIx/Bongo.git'
  s.license      = 'MIT'
  s.authors      = { 'Kostya Bychkov' => 'c.bychkov@gmail.com' }
  s.source       = { :git => 'https://github.com/xNekOIx/Bongo.git', :tag => '0.0.1' }
  s.platform     = :ios, '7.0'
  s.source_files = 'code'
  s.public_header_files = 'code/BNGViewController.h'
  s.requires_arc = true
end
