node do
  {
    'sEcho' => @extra,
    'iTotalRecords' => @items.count,
    'iTotalDisplayRecords' => @items.count,
  }
end
node :aaData do
  @items.map do |x|
    attribute :id => x.ID,
              :policy_id => x.POLICY_ID,
              :parent_id => x.PARENT_ID,
              :target => x.TARGET,
              :hash => x.HASH,
              :enabled => x.ENABLED,
              :limited_day_max => x.LIMITED_DAY_MAX,
              :limited_mon_max => x.LIMITED_MON_MAX,
              :limited_day_phone => x.LIMITED_DAY_PHONE,
              :limited_mon_phone => x.LIMITED_MON_PHONE,
	      :twice_type => x.TWICE_TYPE,
              :created_at => x.CREATED_AT,
              :updated_at => x.UPDATED_AT
  end
end

