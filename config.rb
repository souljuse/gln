page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

ignore '/templates/*'

activate :i18n, :langs => [:it, :en], :mount_at_root => false
activate :asset_hash
activate :directory_indexes
activate :pagination
activate :dato,
  token: 'f62bead0c8e59d044b31',
  base_url: 'https://www.florenceluxuryvillas.com'

activate :external_pipeline,
  name: :webpack,
  command: build? ?
    "./node_modules/webpack/bin/webpack.js --bail -p" :
    "./node_modules/webpack/bin/webpack.js --watch -d --progress --color",
  source: ".tmp/dist",
  latency: 1

set :url_root, 'https://www.florenceluxuryvillas.com'

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
  def localized_paths_for(page)
    return {} if page.path == "index.html"
    localized_paths = {}
    (langs).each do |locale|
      # Loop over all pages to find the ones using the same templates (proxied_to) for each language
      sitemap.resources.each do |resource|
        next if !resource.is_a?(Middleman::Sitemap::ProxyResource)
        if resource.target_resource == page.target_resource
          if resource.metadata[:options][:locale] == locale
            localized_paths[locale] = resource.url
            break
          end
        end
      end
    end

    localized_paths
  end
end


# dato.articles.each do |article|
#   proxy(
#     '/articles/#{article.slug}.html',
#     '/templates/article.html',
#     locals: { article: article }
#   )
# end

# paginate(
#   dato.articles.sort_by(&:published_at).reverse,
#   '/articles',
#   '/templates/articles.html'
# )

# MULTILANG SAMPLES

[:en, :it].each do |locale|
  I18n.with_locale(locale) do
    dato.buildings.each do |building|
      I18n.locale = locale
      proxy "/#{locale}/#{building.slug}/index.html", "/templates/building.html", locals: { building: building }, ignore: true, locale: locale
    end
  end
end

# [:en, :it].each do |locale|
#   I18n.with_locale(locale) do
#     I18n.locale = locale
#     paginate dato.articles.select{|a| a.published == true}.sort_by(&:date).reverse, "/#{I18n.locale}/articles", "/templates/articles.html", locals: { locale: I18n.locale }
#   end
# end
