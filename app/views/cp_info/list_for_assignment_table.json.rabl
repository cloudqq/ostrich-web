node do
  {
    'sEcho' => @extra,
    'iTotalRecords' => @assignments.count,
    'iTotalDisplayRecords' => @assignments.count,
  }
end
node :aaData do
  @assignments.map do |u|
    attribute :spname => u.spinfo.SPNAME,
              :spnumber => u.SPNUMBER,
	      :cmd => u.CMD,
	      :t1 => '',
	      :t2 => '0',
	      :t3 => '0',
	      :arealist => u.AREALIST,
	      :cmdtype => u.CMDTYPE,
	      :spid => u.spinfo.SPID,
	      :id => u.ID
  end
end

