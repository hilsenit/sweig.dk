# Be sure to restart your server when you modify this file.
# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Rails.application.config.assets.paths << Rails.root.join('node_modules')

Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'images', 'new_images')

Rails.application.config.assets.precompile += %w( simple_view.css bootstrap_overwrites.css min-bootstrap search-placeholder.css arrow-up.svg arrow-down.svg search_ajax countdown.css countdown.js)
