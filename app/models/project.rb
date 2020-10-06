class Project
  attr_accessor :tasks, :due_date

  def initialize
     @tasks = []
  end

  def done?
    tasks.all?(&:complete?)
  end

  def total_size
    pp tasks
    tasks.sum(&:size)
  end

  def remaining_size
    tasks.reject(&:complete?).sum(&:size)
  end

  def completed_velocity
    tasks.sum(&:points_toward_velocity)
  end

  def current_rate
    completed_velocity * 1.0/Project.velocity_length_in_days
  end

  def projected_days_remaining
    remaining_size / current_rate
  end

  def on_schedule?
    return false if projected_days_remaining.nan?
    (Time.zone.today+projected_days_remaining) <= due_date
  end

  def self.velocity_length_in_days
    21
  end
end