require 'pry'
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
    html = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
    Nokogiri::HTML(html)
  end

  def get_courses
    self.get_page.css(".post")
  end

  def make_courses
    get_courses.each do |course|
     course_information = Course.new
      course_information.title = course.css("h2").text
      course_information.schedule = course.css(".date").text
      course_information.description = course.css("p").text
    end
  end
end


