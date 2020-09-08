module ProductsHelper
  def currency_type(lang)
    case lang
    
    when 'ja' then
      return '¥'
    when 'en' then
      return '$'
    else
      return '$'
    end
  end
end
