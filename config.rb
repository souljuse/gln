page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

ignore '/templates/*'

activate :asset_hash
activate :directory_indexes
activate :pagination
activate :dato,
  token: '30aafaf3e8ddcc84466c4026f2b907',
  base_url: 'https://www.gruppolucenera.it'

activate :external_pipeline,
  name: :webpack,
  command: build? ?
    "./node_modules/webpack/bin/webpack.js --bail -p" :
    "./node_modules/webpack/bin/webpack.js --watch -d --progress --color",
  source: ".tmp/dist",
  latency: 1

set :url_root, 'https://www.gruppolucenera.com'

configure :build do
  activate :minify_html do |html|
    html.remove_input_attributes = false
  end
  activate :search_engine_sitemap,
    default_priority: 0.5,
    default_change_frequency: 'weekly'
end

configure :development do
  activate :livereload
end

helpers do
  # Returns a hash of localized paths for a given page
  # def localized_paths_for(page)
  #   return {} if page.path == "index.html"
  #   localized_paths = {}
  #   # Loop over all pages to find the ones using the same templates (proxied_to) for each language
  #   sitemap.resources.each do |resource|
  #     next if !resource.is_a?(Middleman::Sitemap::ProxyResource)
  #     if resource.target_resource == page.target_resource
  #       if resource.metadata[:options][:locale] == locale
  #         localized_paths[locale] = resource.url
  #         break
  #       end
  #     end
  #   end
  #
  #   localized_paths
  # end
end

dato.events.each do |event|
  proxy "/#{event.slug}/index.html", "/templates/event.html", locals: { event: event }, ignore: true
end

dato.photo_galleries.each do |photo_gallery|
  proxy "/#{photo_gallery.slug}/index.html", "/templates/photo_gallery.html", locals: { photo_gallery: photo_gallery }, ignore: true
end
