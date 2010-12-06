require 'cucumber/formatter/progress'

module Headshift
  class ProfileFormatter < Cucumber::Formatter::Progress
    def initialize(step_mother, io, options)
      super
      
      @steps = {}
    end
    
    def before_step(*args)
      @timestamp = Time.now
    end
    
    def after_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background)
      if status == :passed
        time = Time.now - @timestamp
        key = step_match.file_colon_line
        if @steps.has_key? key
          # Incremental average time: http://jvminside.blogspot.com/2010/01/incremental-average-calculation.html
          @steps[key][:avg_time] += (time - @steps[key][:avg_time]) / @steps[key][:count]
          @steps[key][:count] += 1
        else
          @steps[key] = {:count => 1, :avg_time => time}
        end
      end
      
      super
    end
    
    def after_features(*args)
      puts
      puts "======================="
      print_formatted_steps(@steps)
    end
    
    def print_formatted_steps(steps, sort_by=:avg_time, limit=20)
      key_width = count_width = avg_time_width = 0
      steps.each do |key, value|
        key_width = [key_width, key.length].max
        count_width = [count_width, value[:count].to_s.length].max
        avg_time_width = [avg_time_width, ("%.6f" % value[:avg_time]).length].max
      end
      
      sorted_steps = steps.sort {|x,y| x[1][:avg_time] <=> y[1][:avg_time]}
      
      puts "| #{"Step".ljust(key_width)} | #{"#".ljust(count_width)} | #{"Avg Time".ljust(avg_time_width)} |"
      sorted_steps.reverse[0..limit].each do |step|
        puts "| #{step[0].ljust(key_width)} | #{step[1][:count].to_s.ljust(count_width)} | #{("%.6f" % step[1][:avg_time]).ljust(avg_time_width)} |"
      end
    end
  end
end