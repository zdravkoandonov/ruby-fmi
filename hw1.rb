def convert_to_bgn(price, currency)
  case currency
    when :bgn
      price.round(2)
    when :usd
      (price * 1.7408).round(2)
    when :eur
      (price * 1.9557).round(2)
    when :gbp
      (price * 2.6415).round(2)
  end
end

def compare_prices(first_price, first_currency, second_price, second_currency)
  first_price_bgn = convert_to_bgn(first_price, first_currency)
  second_price_bgn = convert_to_bgn(second_price, second_currency)

  first_price_bgn <=> second_price_bgn
end