module AssetHelpers

  def bem_blocks
    sitemap.resources.map(&:path)
      .select { |p| p.start_with? "stylesheets/blocks"}
      .map { |p| p.delete_prefix("stylesheets/").delete_suffix(".css")}
      .map { |item| stylesheet_link_tag item }
      .sort.join("\n")
  end

  def unpoly_compilers
    sitemap.resources.map(&:path)
      .select { |p| p.start_with? "javascripts/compilers"}
      .map { |p| p.delete_prefix("javascripts/").delete_suffix(".js")}
      .map { |item| javascript_include_tag item, type: "module", defer: true }
      .sort.join("\n")
  end

end

