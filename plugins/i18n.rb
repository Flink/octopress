module Jekyll
  class TranslateTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text
      load_locales
    end

    def render(context)
      I18n.locale = self.site.config.locale
      I18n.t "site.#@text"
    end

    private
    def load_locales
      return unless I18n.available_locales.empty?
      I18n.load_path = Dir.glob File.expand_path('../../locales/*', __FILE__)
      I18n.backend.load_translations
    end
  end
end
Liquid::Template.register_tag('t', Jekyll::TranslateTag)
