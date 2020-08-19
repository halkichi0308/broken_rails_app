module ApplicationHelper
    
  def if_content_tag(element, innerText, *attrs)
    className = nil
    attrs.each do |attr|
      if attr[:class]
        className = attr[:class]
      end
    end
    if innerText
      #binding.pry
      isClassAry = className ? {class: "#{className}"} : nil
      content_tag element, innerText, isClassAry
    end
  end

  def set_icon(icon_name)
    content_tag :i, icon_name, class: "material-icons"
  end

  def row_render(&html_block)
    if block_given?
      content_tag(:div, class: "row") do
        concat content_tag :div, "", class: ["col", "s2"]
          html_block.call
        concat content_tag :div, "", class: ["col", "s2"]
      end
    end
  end

  def parse_product_id(id)
    len = id.to_s.length
    return "EC" + "0" * (10 - len) + id.to_s
  end
end
