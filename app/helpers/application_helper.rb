module ApplicationHelper
  def seo_title(value)
    content_for(:seo_title, value + ' / ' + default_seo_title)
  end

  def seo_description(value)
    content_for(:seo_description, value)
  end

  def seo_keywords(value)
    content_for(:seo_keywords, value)
  end

  def default_seo_title
    t('default_seo_title')
  end


  def tel_to(text)
    groups = text.to_s.scan(/(?:^\+)?\d+/)
    link_to text, "tel:#{groups.join '-'}"
  end

  def render_pagination(collection, options = {})
    html = ''

    begin
      # FIXME
      if collection.next_page.present?
        html += link_to('Показать больше материалов', url_for(params.merge(:page => collection.next_page)), :class => 'btn btn-lg btn-default', :role => 'more')
      end
    rescue
      nil
    end

    html += paginate(collection, :options => options, :window => 2, :left => 1, :right => 1)

    content_tag(:div, html.html_safe, class: 'pagination_container', role: 'pagination')
  end
end
