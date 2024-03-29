page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

ignore '/templates/*'
ignore '/stylesheets/*'

activate :asset_hash
activate :directory_indexes
activate :pagination
activate :dato,
  token: '30aafaf3e8ddcc84466c4026f2b907',
  base_url: 'https://www.gruppolucenera.it'


set :url_root, 'https://www.gruppolucenera.it'

activate :external_pipeline,
  name: :webpack,
  command: build? ?
    "./node_modules/webpack/bin/webpack.js --bail --progress" :
    "./node_modules/webpack/bin/webpack.js --watch --progress --color",
  source: ".tmp/dist",
  latency: 1

configure :development do
  activate :livereload
end

configure :build do
  activate :minify_html do |html|
    html.remove_input_attributes = false
  end

  activate :search_engine_sitemap,
    default_priority: 0.5,
    default_change_frequency: 'weekly'
end

dato.tap do |dato|
  # paginate dato.events.sort_by(&:name), "/events", "/templates/event.html", per_page: 20

  dato.events.each do |event|
    proxy "/eventi/#{event.slug}.html", "/templates/event.html", locals: { event: event }, :layout => "layout"
  end

  dato.photo_galleries.each do |gallery|
    proxy "/foto/#{gallery.slug}.html", "/templates/gallery.html", locals: { gallery: gallery }, :layout => "layout"
  end

  # paginate dato.rule_chapters.sort_by(&:title), "/regolamento", "/templates/chapter.html", per_page: 20

  dato.rule_chapters.each do |chapter|
    proxy "/regolamento/#{chapter.slug}.html", "/templates/chapter.html", locals: { chapter: chapter, parent: "regolamento" }, :layout => "layout"

    chapter.subchapters.each do |sub|
      proxy "/regolamento/#{chapter.slug}/#{sub.slug}.html", "/templates/subchapter.html", locals: { chapter: sub, parent: "regolamento" }, :layout => "layout"
    end
  end

  dato.settings_chapters.each do |chapter|
    proxy "/ambientazione/#{chapter.slug}.html", "/templates/chapter.html", locals: { chapter: chapter, parent: "ambientazione" }, :layout => "layout"

    chapter.subchapters.each do |sub|
      proxy "/ambientazione/#{chapter.slug}/#{sub.slug}.html", "/templates/subchapter.html", locals: { chapter: sub, parent: "ambientazione" }, :layout => "layout"
    end
  end
end

helpers do
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new

    Redcarpet::Markdown.new(renderer, :tables => true).render(text)
  end

  def image_or_missing(image)
    if image
      yield image
    else
      image_tag "/images/missing-image.png"
    end
  end
end
