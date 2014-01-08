node do
  {
    'sEcho' => @extra,
    'iTotalRecords' => @items.count,
    'iTotalDisplayRecords' => @items.count,
  }
end
node :aaData do
  @items.map do |x|
    attribute :target => x.TARGET, 
	      :enabled => x.ENABLED,
	      :limited_day_max => x.LIMITED_DAY_MAX,
	      :limited_mon_max => x.LIMITED_MON_MAX,
	      :limited_day_phone => x.LIMITED_DAY_PHONE,
	      :limited_mon_phone => x.LIMITED_MON_PHONE,
	      :spnumber => x.cpbusiness.SPNUMBER,
	      :cmd => x.cpbusiness.CMD,
	      :created_at => x.CREATED_AT,
	      :updated_at => x.UPDATED_AT.strftime("%F %T")
  end
end

