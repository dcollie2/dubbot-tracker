module ScansHelper
  def scan_sort_link(column:, label:, **options)
    direction = column == params[:column] ? scan_next_direction : 'desc'
    link_to(label, list_scans_path(column: column, direction: direction, system_id: options[:system_id]))
  end

  def scan_next_direction
    params[:direction] == 'asc' ? 'desc' : 'asc'
  end

  def sort_indicator
    tag.span(class: "sort sort-#{params[:direction]}")
  end


end
