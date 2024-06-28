class JobController < ApplicationController
  def index
  end

  def startRetrieveSongUrlsJob
    job = RetrieveSongUrlsJob.new
    job.perform

    redirect_to job_index_url
  end
end
