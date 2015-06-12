# Time formatting

def time_format(time)
  if time < 1.0
    format('%.0fms', time * 1000.0)
  else
    format('%.3fs', time)
  end
end
