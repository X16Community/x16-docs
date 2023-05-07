function RawBlock (raw)
  return raw.format:match 'html'
    and pandoc.read(raw.text, 'html').blocks
    or raw
end
