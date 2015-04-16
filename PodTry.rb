#
# Be sure to run `pod lib lint Demo.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "PodTry"
  s.version          = "0.0.1"
  s.summary          = "This is a Simple Demo Library"
  s.description      = "This library is to check how a simple demo project would work with private pod spec and source pointing to the private pod spec"
  s.homepage         = "https://github.com/iamnpr/PodTry.git"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Naveen Prasad Raja" => "iamnpr@outlook.com" }
  s.source           = { :git => "https://github.com/iamnpr/PodTry.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/iamnpr'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'PodTry/PodTry/**/*'
  s.resource_bundles = {
    'Demo' => ['PodTry/PodTry/*.png']
  }
  
  s.post_install do |library_representation|
    require 'rexml/document'

    library = library_representation.library
    proj_path = library.user_project_path
    proj = Xcodeproj::Project.new(proj_path)
    target = proj.targets.first 

    info_plists = target.build_configurations.inject([]) do |memo, item|
      memo << item.build_settings['INFOPLIST_FILE']
    end.uniq
    info_plists = info_plists.map { |plist| File.join(File.dirname(proj_path), plist) }

    resources = library.file_accessors.collect(&:resources).flatten
    accessorys = resources.find_all { |file| File.extname(file) == '.intg' }
   
    info_plists.each do |plist|
      doc = REXML::Document.new(File.open(plist))
      main_dict = doc.elements["plist"].elements["dict"]
      Extenal_Accessory = main_dict.get_elements("key[text()='UISupportedExternalAccessoryProtocols']").first
      if Extenal_Accessory.nil?
        elem = REXML::Element.new 'key'
        elem.text = 'UISupportedExternalAccessoryProtocols'
        main_dict.add_element(elem)
        accessory_array = REXML::Element.new 'array'
        main_dict.add_element(accessory)
      else
        accessory_array = Extenal_Accessory.next_element
      end

      accessorys.each do |accessory|
        if accessory_array.get_elements("string[text()='#{accessory}']").empty?
          accessory_elem = REXML::Element.new 'string'
          accessory_elem.text = accessory
          accessory_array.add_element(accessory_elem)
        end
      end

      doc.write(File.open(plist, 'wb'))
    end
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
