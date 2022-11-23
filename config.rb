# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

activate :livereload

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings
configure :build do
  # set :http_prefix,"/portfolio"
  # don't process reveal.js, because it was copied to build/ manually
  ignore 'assets/*'
  # and protect it from being deleted on build
  set :skip_build_clean, Proc.new { 'assets/*' }

  # activate :minify_css
  # activate :minify_javascript
end

# activate livereload for helpers
# Dir['helpers/*'].each(&method(:load))

# set :relative_links, true
require "helpers/data_helpers"
include DataHelpers
helpers DataHelpers

proxy "/projects.html", "/projects/index.html", locals:  {slug_filter: nil}  , :ignore => true

data.skills.each do |s|
  proxy "/projects/using/#{s.slug}.html", "/projects/index.html", locals: { slug_filter: s.slug } , :ignore => true
end

data.projects.each do |p|
  proxy "/projects/#{p.slug}.html", "/projects/show.html", locals: { project: p } , :ignore => true
end

data.skills.each do |s|
  proxy "/skills/#{s.slug}.html", "/skills/show.html", locals: { skill: s } , :ignore => true
end

