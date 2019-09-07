require 'nokogiri'
require 'open-uri'

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
  
  def get_page
    @@doc = Nokogiri::HTML(open('http://learn-co-curriculum.github.io/site-for-scraping/courses'))
  end 
  
  def get_courses
    @@doc.css('.post')
  end 
  
  def make_courses
    self.get_courses.each do |course|
      course = Course.new 
      course.title = @@doc.css("h2").text
      course.schedule = @@doc.css('.date').text 
      course.description = @@doc.css('p').text 
    end 
  end 
  
end



