class StringCalculator
    DELIMETER_PREFIX = '//'.freeze
  
    def run(input)
      raise ArgumentError.new('Error') if has_negative_number?(input)
      raise ArgumentError.new('Error') if end_with_delimiter?(input)
      
      delimeter = /[\\n,]/
      if has_custom_delimeter?(input)
        delimeter_regex, input = input.split(/\\n/)
        delimeter = extract_delimeter_character(delimeter_regex)
      end
  
      sum(input, delimeter)
    end

    def end_with_delimiter?(input)
        input.end_with?("n", ",")
    end

    def has_negative_number?(input)
        input.include?("-")
    end

  
    def sum(input, delimeter)
      input.split(delimeter)
           .map(&:to_i)
           .reject { |number| number > 1000 }
           .inject(0) { |acc, n| acc += n }
    end
  
    def has_custom_delimeter?(input)
      input.start_with?(DELIMETER_PREFIX)
    end
  
    def extract_delimeter_character(delimeter_regex)
      multiple_chars_delimeter = delimeter_regex.match(/\/\/\[(.*)\]/)

      if multiple_chars_delimeter
        multiple_chars_delimeter.captures.first
      else
        delimeter_regex.gsub(%r{[/,[,]]}, '')
      end
    end
  end