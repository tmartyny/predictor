module PredictionConcerns
  extend ActiveSupport::Concern
  included do
    def top_input2_range 
      @input2 + input2_flex
    end
    def bottom_input2_range 
      @input2 - input2_flex
    end
    def top_input1_range 
      @input1 + input1_flex
    end
    def bottom_input1_range 
      @input1 - input1_flex
    end
    def input2_match(person_input2)
      (bottom_input2_range..top_input2_range).include?(person_input2)
    end
    def input1_match(person_input1)
      (bottom_input1_range..top_input1_range).include?(person_input1)
    end
    def add_estimates
      @aggregate_user_data.each do |person|
        if input2_match(person[1]) && input1_match(person[0]) # weighted
          case person[2] 
          when 0
            @outcome2_input2_estimates += 3 
            @outcome2_input1_estimates += 3
          when 1
            @outcome1_input2_estimates += 3
            @outcome1_input1_estimates += 3
          end
        elsif input2_match(person[1]) #not weighted
          @outcome2_input2_estimates += 1 if person[2] == 0
          @outcome1_input2_estimates += 1 if person[2] == 1
        elsif input1_match(person[0]) #not weighted
          @outcome2_input1_estimates += 1 if person[2] == 0
          @outcome1_input1_estimates += 1 if person[2] == 1
        end
      end
    end
    def total_outcome2_estimates
      @outcome2_input2_estimates + @outcome2_input1_estimates
    end
    def total_outcome1_estimates
      @outcome1_input2_estimates + @outcome1_input1_estimates
    end
    def select_random
      [outcome1, outcome2].shuffle.pop
    end
  end
end