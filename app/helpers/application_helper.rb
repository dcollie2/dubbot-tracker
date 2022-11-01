module ApplicationHelper
  def batch_date_header
    tag.h2 "Scans imported on #{Scan.most_recent_batch_date.to_fs(:long)}" if Scan.most_recent_batch_date.present?
  end
end
