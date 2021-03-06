# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strict
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/chromedriver-helper/all/chromedriver-helper.rbi
#
# chromedriver-helper-2.1.1

module Chromedriver
  def self.set_version(version); end
end
class Chromedriver::Helper
  def base_install_dir; end
  def binary_path; end
  def current_version; end
  def download(hit_network = nil); end
  def download_url; end
  def download_version; end
  def google_code_parser; end
  def platform; end
  def platform_install_dir; end
  def run(*args); end
  def update(version = nil); end
  def version_install_dir; end
  def version_path; end
end
class Chromedriver::Helper::GoogleCodeParser
  def downloads; end
  def grab_version_string_from(url); end
  def initialize(platform, open_uri_provider = nil); end
  def newest_download_version; end
  def platform; end
  def source; end
  def version_download_url(version); end
  def version_of(url); end
end
