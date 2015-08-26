#!/bin/env ruby
# encoding: utf-8

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
        html += content_tag(:div, link_to('Показать больше моделей', url_for(params.merge(:page => collection.next_page, id: collection.first.gallery.id )), :class => 'btn btn-lg btn-default', :role => 'more'), class: 'text-center')
      end
    rescue
      nil
    end

    html += paginate(collection, :options => options, :window => 2, :left => 1, :right => 1)

    content_tag(:div, html.html_safe, class: 'col-md-12 col-xs-12 text-center', role: 'pagination')
  end
end
