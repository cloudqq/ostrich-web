node do
  {
    'sEcho' => @extra,
    'iTotalRecords' => @items.length,
    'iTotalDisplayRecords' => @items.length
  }
end
node :aaData do
  @items.map do |u|
    attribute :province => u.PROVINCE,
              :cpid => u.CPID,
              :spid => u.SPID,
              :spname => u.spinfo.SPNAME,
              :cpname => u.cpinfo.CPNAME,
              :spnumber => u.SPNUMBER,
	      :cmd => u.CONTENT,
              :mo_count => u.MO,
	      :discount => u.DISCOUNT,
              :not_forward => u.NOT_FORWARD,
              :dispatched => u.DISPATCHED
  end
end

