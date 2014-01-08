node do
  {
    'sEcho' => @extra,
    'iTotalRecords' => @items.count,
    'iTotalDisplayRecords' => @items.count,
  }
end
node :aaData do
  @items.map do |u|
    attribute :id => u.ID,
              :mt_content => u.MT_CONTENT,
	      :sp_business_id => u.SP_BUSINESS_ID
  end
end

