require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
  #use nokogiri, open-uri to grab html doc
  def get_page
    doc=Nokogiri::HTML(open('http://learn-co-curriculum.github.io/site-for-scraping/courses'))
    #binding.pry
  end

  #use CSS selector to grab all HTML elements that contain a course
  #return a collection of Nokogiri XML elems that each describe a course
  def get_courses
    self.get_page.css(".post")
    #binding.pry
  end

  #instantiate Course objects, give correct title, sched, description
  def make_courses
    self.get_courses.each do |post|
      course=Course.new
      course.title=post.css("h2").text
      course.schedule=post.css(".date").text
      course.description=post.css("p").text
    end
  end

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
  
end

Scraper.new.print_courses

