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
    "Обувь Стиль — обувной магазин в городе Твери"
  end
end
