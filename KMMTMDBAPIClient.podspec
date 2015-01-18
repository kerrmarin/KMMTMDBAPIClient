#
# Be sure to run `pod lib lint KMMTMDBAPIClient.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "KMMTMDBAPIClient"
  s.version          = "1.4.1"
  s.summary          = "A TMDB API client"
  s.description      = <<-DESC
                        A client to interact with the TMDB API and perform queries.
                       DESC
  s.homepage         = "https://github.com/kerrmarin/KMMTMDBAPIClient"
  s.license          = 'MIT'
  s.author           = { "Kerr Marin Miller" => "kerr@kerrmarin.com" }
  s.source           = { :git => "https://github.com/kerrmarin/KMMTMDBAPIClient.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/kerrmarin'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'KMMTMDBAPIClient' => ['Pod/Assets/*.png']
  }

  s.dependency 'AFNetworking', '~> 2.5'

end
