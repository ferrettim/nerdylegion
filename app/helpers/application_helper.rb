module ApplicationHelper
  include Pagy::Frontend
  
  def meta_title(page_title)
    content_for(:meta_title) { page_title }
  end

  def meta_description(page_text)
    content_for(:meta_description) { page_text }
  end

  def og_title(og_title)
    content_for(:og_title) { og_title }
  end

  def og_description(og_description)
    content_for(:og_description) { og_description }
  end

  def og_type(og_type)
    content_for(:og_type) { og_type }
  end

  def og_audio(og_audio)
    content_for(:og_audio) { og_audio }
  end

  def og_url(og_url)
    content_for(:og_url) { og_url }
  end

  def og_image(og_image)
    content_for(:og_image) { og_image }
  end

end
