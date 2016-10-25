module SidekiqHelpers
  def clear_jobs_queue
    Sidekiq::Worker.clear_all
  end
end
