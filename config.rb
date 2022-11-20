# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

# activate :autoprefixer do |prefix|
#   prefix.browsers = "last 2 versions"
# end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  def cube(colors, alg = '', size = :big)
    color_confs = {
      scrambled: "setupmoves=L2 B' R' D' B' D' R' B2 D R' D R' B U' F U2 B' D2 F' B2 L F2 R2 F' B2",
      cross: 'colored=D*/em F L R B',
      cross2f2lminus: 'colored=DFL FL DLB LB DBR BR|solved=D*/em F L R B',
      f2lminus: 'colored=D*/em F L R B DFL FL DLB LB DBR BR',
      f2lminus2eo: 'colored=U Uf Ub Ul Fr|solved=D*/em F L R B DFL FL DLB LB DBR BR|tweaks=U:Fr',
      eo: '',
      eo2edges: 'colored=U UF UB UL UR FR|solved=D*/em F L R B DFL FL DLB LB DBR BR',
      edges: 'colored=*/em|solved=D*/e DFL FL DLB LB DBR BR',
      edges2full: 'colored=*/em DFL DLB DBR',
      full: '*',
      f2l: 'colored=U-',
      oll: 'colored=D* u F FL L LB B BR R RF',
      elevator_r: 'colored=DFR FR UFL UF|solved=D*/em F L R B|tweaks=L:dFR L:FR B:UFl B:UF D:Dfr D:ufL',
      elevator_f: 'colored=DFR FR URB UR|solved=D*/em F L R B|tweaks=L:dFR L:FR B:URb B:UR D:Dfr D:urB',
      edge_flip: 'colored=U Ur|solved=D*/em F L R B DFL FL DLB LB DBR BR',
      practice_f2l: "setupmoves=B' U2 L' B2 F' R' U2 R' F' B2 U' L R F' B2 R' L2 U' L R' B F2 R F R' D' L' B' F' D'",
      practice_edges: "colored=U*/em FR R B L F|solved=D*/em DFL FL DLB LB DBR BR|setupmoves=F' U2 F R U R' U' F' U' F",
      practice_comms: "colored=U*/c DFR B R D F L U|solved=D*/e FR RB BL LF U*/e DFL DLB DBR",
    }

    conf = [
      "alg=#{alg}",
      color_confs.key?(colors) ? color_confs[colors] : colors,
      "hover=2",
      "flags=showalg",
      "algdisplay=fancy2s"
    ]

    content_tag(:div, nil, class: "roofpig -#{size}", 'data-config': conf.join('|'))
  end

  def markdown(text)
    content_tag(:section, 'data-markdown': true) do
       content_tag(:script, text, type: 'text/template')    
    end   
  end

  def method(name)
    partial('method', locals: { name: name })
  end

  def atj
    content_tag(:p, class: "neon -red") do
      content_tag(:a, 'alignJoin', class: "plain-link", href: "#/atj")
    end
  end
  
  def dar
    content_tag(:p, class: "neon -yellow") do
      content_tag(:a, 'breakRestore', class: "plain-link", href: "#/dar")
    end
  end

  def sum
    content_tag(:p, 'setupMoves', class: "neon -yellow")
  end

  def rp
    content_tag(:p, class: "neon -blue") do
      content_tag(:a, 'relPos', class: "plain-link", href: "#/rp")
    end
  end

  # def cube(config)
  #   content_tag(:div, class: 'cube') do
  #     content_tag(:script) do
  #       'AnimCube3("config=AnimCube3Config.txt")'
  #     end
  #   end      
  # end

end

# activate :livereload

# turn off markdown, handled by reveal.js
Tilt.default_mapping.template_map.delete('md')
Tilt.default_mapping.template_map.delete('mkd')
Tilt.default_mapping.template_map.delete('mkdn')
Tilt.default_mapping.template_map.delete('mdown')
Tilt.default_mapping.template_map.delete('markdown')

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings
configure :build do
  set :http_prefix,"/portfolio"
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

