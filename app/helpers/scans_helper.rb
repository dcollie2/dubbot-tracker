module ScansHelper
  def scan_sort_link(column:, label:)
    if column == params[:column]
      link_to(label, list_scans_path(column: column, direction: scan_next_direction))
    else
      link_to(label, list_scans_path(column: column, direction: 'desc'))
    end
  end

  def scan_next_direction
    params[:direction] == 'asc' ? 'desc' : 'asc'
  end

  def sort_indicator
    tag.span(class: "sort sort-#{params[:direction]}")
  end


end
