node do
  {
    'sEcho' => @extra,
    'iTotalRecords' => @usages.count,
    'iTotalDisplayRecords' => @usages.count,
  }
end
node :aaData do
  @usages.map do |u|
    attribute :cmd => u.CMD,
              :spid => u.SP_ID
  end
end

