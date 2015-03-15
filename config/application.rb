require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ecoma
  class Application < Rails::Application
    # フォントファイル等をプリコンパイル（実質publicフォルダへの再配置に過ぎない）
    config.assets.precompile += %w( *.svg *.eot *.woff *.ttf )
  end
end
