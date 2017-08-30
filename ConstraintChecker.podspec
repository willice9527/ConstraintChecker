

Pod::Spec.new do |s|
  s.name             = 'ConstraintChecker'
  s.version          = '0.1.1'
  s.summary          = 'ambiguous constraint debugger'

  s.description      = <<-DESC
  A tool that help you find ambiguous constraint automatically,just install it(only in debug mode will be much safer),no extra configration needed;
  Once some ambiguous constraints discoverd,a flashing button will appeared on top of the screen.Click it will log all infomation to console which will be great help for identify the problem,meanwhile the condemned view will be marked with red border.
  Only the view hierarchy being diplayed will be checked.
                       DESC

  s.homepage         = 'https://github.com/willice9527/ConstraintChecker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'willice9527' => 'nwpu_liuzhou@163.com' }
  s.source           = { :git => 'https://github.com/willice9527/ConstraintChecker.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'ConstraintChecker/Classes/**/*','ConstraintChecker/**/*'

  s.frameworks = 'UIKit', 'Foundation'
end
