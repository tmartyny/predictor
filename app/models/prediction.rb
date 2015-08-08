class Prediction
  include PredictionConcerns
  attr_reader :input1, 
              :input1_flex,
              :input2, 
              :input2_flex,
              :aggregate_user_data, 
              :outcome1, 
              :outcome2
  def initialize(args)
    @aggregate_user_data = args.fetch(:aggregate_user_data) #nested array
    @input1 = args.fetch(:input1) #integer
    @input2 = args.fetch(:input2) #integer
    @outcome1 = args.fetch(:outcome1) #ie: output= string
    @outcome2 = args.fetch(:outcome2) #ie: output= string
    @input1_flex = args.fetch(:input1_flex) #integer 
    @input2_flex = args.fetch(:input2_flex) #integer
    @outcome2_input2_estimates = 0
    @outcome2_input1_estimates = 0
    @outcome1_input2_estimates = 0
    @outcome1_input1_estimates = 0
  end
  
  def render
    add_estimates
    return select_random if total_outcome1_estimates == total_outcome2_estimates
    if total_outcome1_estimates > total_outcome2_estimates
      outcome1 
    elsif total_outcome1_estimates < total_outcome2_estimates
      outcome2
    end
  end
end

