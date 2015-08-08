module PersonConcerns
  extend ActiveSupport::Concern
  included do
    @@aggregate = [[100, 50, 1],
              [400, 60, 0],
              [50, 72, 1],
              [240, 80, 0],
              [140, 48, 1],
              [340, 64, 0]]
    def verify
      {"Man" => 1, "Woman" => 0}
    end
    def add_person_to_aggregate
      @@aggregate << [self.weight, self.height, self.gender.to_i]
    end
    def compile_user_data
      Person.all.each do |person|
        (@@aggregate << [person.weight, person.height, person.gender]) if !person.gender.nil?
      end
    end
    # if the server goes down and the dataset reverts to the default data
    def include_gathered_data
      compile_user_data if @@aggregate.length == 6
    end
    def create_prediction
      p "aggregate prediction is based on: #{@@aggregate}"
      p "testing: weight: #{self.weight}, height: #{self.height}"
      @assume = Prediction.new(
                  input1: self.weight, 
                  input1_flex: 20,
                  input2: self.height,
                  input2_flex: 6,
                  aggregate_user_data: @@aggregate,
                  outcome1: "Man",
                  outcome2: "Woman"
                  )
    end
    def set_prediction
      @assume.render
    end
  end
end