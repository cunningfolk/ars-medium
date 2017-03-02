include YARD
include Templates

module MarkdownHelper
  def format
    :md
  end
end

Template.extra_includes << proc {|opts| MarkdownHelper if opts.format == :md}
Engine.register_template_path(File.dirname(__FILE__))
