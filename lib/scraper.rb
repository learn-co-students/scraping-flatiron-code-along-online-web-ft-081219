require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
  def self.get_page
    @@doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    binding.pry
  end
  
  def get_courses
    @@doc.css(".posts-holder")
  end
  
  def make_courses
    get_courses.each do |elements|
      course = Course.new
      course.title = elements.css("h2").text
      course.schedule = elements.css(".date").text
      course.description = elements.css("p").text
    end
  end
end



