begin
  require 'awesome_print'
rescue LoadError
end

require 'nokogiri'
require 'faraday'
require 'motocross_gear/version'

$doc = nil
module MotocrossGear
  # catalog of websites
  # websites have kits
  # kits have pictures, price, (availability? colorways?)
  require 'ostruct'
  Kit = Struct.new(:name, :image, :url)
  THORMX = {
    root: 'http://www.thormx.com',
    kits: '/products/?categoryId=7075'
  }
  def self.run
    connection = Faraday.new(url: THORMX.fetch(:root))
    response = connection.get(THORMX.fetch(:kits))
    $doc = Nokogiri::HTML(response.body)
    #ap $doc

    $doc.css('#content').first.css('.productImage').map do |product|
      name = product.css('.productNameText').first.text.to_s
      image = product.css('img').first.attributes["src"].to_s
      url = product.css('a').first.attributes["href"].to_s
      Kit.new(name, image, url)
    end

    #entries = doc.css('.lagos-market-rates-inner')
  end

  def self.reload!
    (MotocrossGear.constants - [:VERSION]).each do |const|
      remove_const(const)
    end
    load 'motocross_gear.rb'
  end
end

def reload!
  MotocrossGear.reload!
end

def run
  MotocrossGear.run
end
