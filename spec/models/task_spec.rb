require 'rails_helper'

RSpec.describe Task do
  describe "initial" do
    let(:task){ Task.new(size: 1) }
    it "does not have a new task as complete" do
      expect(task).not_to be_complete  
    end

    it "allow us to complete task" do
      task.mark_completed
      expect(task).to be_complete  
    end
  end

  describe "velocity" do
    let(:task){ Task.new(size: 3)}

    it "does not count and incomplete task toward velocity" do
      expect(task).not_to be_a_part_of_velocity
      expect(task.points_toward_velocity).to eq(0) 
    end

    it "counts recentyl complted task toward velocity" do
      task.mark_completed(1.day.ago)
      expect(task).to be_a_part_of_velocity
      expect(task.points_toward_velocity).to eq(3)
    end

    it "does not count long ago completed task towards velocity" do
      task.mark_completed(6.months.ago)
      expect(task).not_to be_a_part_of_velocity
      expect(task.points_toward_velocity).to eq(0) 
    end
  end
end
